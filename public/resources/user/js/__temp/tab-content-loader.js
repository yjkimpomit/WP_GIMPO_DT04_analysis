(function () {
    'use strict';

    function createLoader(root) {
        if (!root || root.dataset.tabLoaderInitialized) return null;

        var tabList = root.querySelector('[role="tablist"]');
        var tabs = tabList ? Array.from(tabList.querySelectorAll('[role="tab"]')) : [];
        var panels = Array.from(root.querySelectorAll('[role="tabpanel"]'));

        if (!tabList || !tabs.length || !panels.length) return null;
        root.dataset.tabLoaderInitialized = 'true';

        var loadingSelector = root.getAttribute('data-loading-target');
        var loadingBar = loadingSelector ? document.querySelector(loadingSelector) : null;
        var activeRequest = null;

        function getTargetSelector(tab) {
            var selector = tab.getAttribute('data-target') || tab.getAttribute('data-bs-target');
            var targetId = tab.getAttribute('data-tab-target');
            return selector || (targetId ? '#' + CSS.escape(targetId) : '');
        }

        function getPanel(tab) {
            var selector = getTargetSelector(tab);
            var target = selector ? root.querySelector(selector) : null;
            return target ? target.closest('[role="tabpanel"]') || target : panels[0];
        }

        function getUrl(tab) {
            return tab.getAttribute('data-page') || tab.getAttribute('data-tab-url');
        }

        function setLoading(isLoading) {
            if (!loadingBar) return;
            loadingBar.hidden = !isLoading;
            loadingBar.style.display = isLoading ? '' : 'none';
        }

        function activateTab(selectedTab) {
            var selectedPanel = getPanel(selectedTab);
            var staticTarget = selectedTab.getAttribute('data-tab-target');
            var staticContent = staticTarget ? root.querySelector('#' + CSS.escape(staticTarget)) : null;
            var bootstrapTab = window.Tab;

            if (bootstrapTab && typeof bootstrapTab.getOrCreateInstance === 'function') {
                bootstrapTab.getOrCreateInstance(selectedTab).show();
                panels.forEach(function (panel) {
                    panel.removeAttribute('hidden');
                });
                selectedPanel.scrollTop = 0;
                return;
            }

            tabs.forEach(function (tab) {
                var isSelected = tab === selectedTab;
                tab.classList.toggle('active', isSelected);
                tab.setAttribute('aria-selected', String(isSelected));
                tab.setAttribute('tabindex', isSelected ? '0' : '-1');
            });

            panels.forEach(function (panel) {
                var isSelected = panel === selectedPanel;
                panel.toggleAttribute('hidden', !isSelected);
            });

            if (staticContent && staticContent !== selectedPanel) {
                selectedPanel.querySelectorAll('[data-tabs-content]').forEach(function (content) {
                    content.toggleAttribute('hidden', content.id !== staticTarget);
                });
            }

            selectedPanel.setAttribute('aria-labelledby', selectedTab.id);
            selectedPanel.scrollTop = 0;
        }

        function renderError(panel) {
            var message = document.createElement('p');
            message.className = 'tabs__error';
            message.setAttribute('role', 'alert');
            message.textContent = '콘텐츠를 불러오지 못했습니다.';
            panel.replaceChildren(message);
        }

        function renderContent(panel, html) {
            var selector = root.getAttribute('data-content-selector');
            if (selector === 'none') {
                panel.innerHTML = html;
                return;
            }

            var page = new DOMParser().parseFromString(html, 'text/html');
            var content = page.querySelector(selector || '.page-content');
            var importedContent = content ? document.importNode(content, true) : document.importNode(page.body, true);
            panel.replaceChildren(importedContent);
        }

        async function loadTab(selectedTab) {
            var panel = getPanel(selectedTab);
            var url = getUrl(selectedTab);

            if (!panel || !url) return;
            if (activeRequest) activeRequest.abort();

            var request = new AbortController();
            activeRequest = request;

            if (typeof window.closeOtherPopups === 'function') window.closeOtherPopups();
            panel.setAttribute('aria-busy', 'true');
            setLoading(true);

            try {
                var response = await fetch(url, {
                    method: root.getAttribute('data-load-method') || 'GET',
                    headers: { 'X-Requested-With': 'XMLHttpRequest' },
                    signal: request.signal
                });

                if (!response.ok) throw new Error('HTTP ' + response.status);
                renderContent(panel, await response.text());

                var detail = { tab: selectedTab, panel: panel, url: url };
                root.dispatchEvent(new CustomEvent('tabcontentloaded', { bubbles: true, detail: detail }));
                panel.dispatchEvent(new CustomEvent('tabs:content-loaded', { bubbles: true, detail: detail }));
            } catch (error) {
                if (error.name === 'AbortError') return;
                renderError(panel);
                console.error('탭 콘텐츠 로드 실패:', error);
            } finally {
                panel.removeAttribute('aria-busy');
                if (activeRequest === request) {
                    activeRequest = null;
                    setLoading(false);
                }
            }
        }

        function selectTab(tab, moveFocus) {
            if (!tab || tab.disabled || tab.classList.contains('disabled')) return;

            activateTab(tab);
            loadTab(tab);
            if (moveFocus) tab.focus();

            root.dispatchEvent(new CustomEvent('tabs:change', {
                bubbles: true,
                detail: { tab: tab, key: tab.dataset.tabKey || tab.dataset.tabTarget || tab.id }
            }));
        }

        tabList.addEventListener('click', function (event) {
            var tab = event.target.closest('[role="tab"]');
            if (!tab || !tabList.contains(tab)) return;
            event.preventDefault();
            selectTab(tab, false);
        });

        tabList.addEventListener('keydown', function (event) {
            var currentIndex = tabs.indexOf(event.target);
            var nextIndex;

            if (currentIndex < 0) return;
            if (event.key === 'ArrowRight') nextIndex = (currentIndex + 1) % tabs.length;
            if (event.key === 'ArrowLeft') nextIndex = (currentIndex - 1 + tabs.length) % tabs.length;
            if (event.key === 'Home') nextIndex = 0;
            if (event.key === 'End') nextIndex = tabs.length - 1;
            if (typeof nextIndex !== 'number') return;

            event.preventDefault();
            selectTab(tabs[nextIndex], true);
        });

        var parameters = new URLSearchParams(window.location.search);
        var parameterName = root.getAttribute('data-tab-param') || 'tabIdx';
        var queryValue = parameters.get(parameterName) || parameters.get('tab') || parameters.get('unit');
        var queryIndex = Number.parseInt(queryValue, 10);
        var initialTab = tabs.find(function (tab) { return tab.dataset.tabKey === queryValue; });

        if (!initialTab && Number.isInteger(queryIndex)) initialTab = tabs[queryIndex];
        if (!initialTab) initialTab = tabs.find(function (tab) { return tab.getAttribute('aria-selected') === 'true'; });

        selectTab(initialTab || tabs[0], false);
        return { select: selectTab, load: loadTab };
    }

    function initAll(scope) {
        return Array.from((scope || document).querySelectorAll('[data-tab-content-loader]'))
            .map(createLoader)
            .filter(Boolean);
    }

    window.TabContentLoader = { init: createLoader, initAll: initAll };
    initAll(document);
    document.addEventListener('tabs:content-loaded', function (event) {
        initAll(event.target);
    });
}());
