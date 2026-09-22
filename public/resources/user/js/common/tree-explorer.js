function initTreeExplorers(root = document) {
	root.querySelectorAll('[role="tree"]').forEach((tree) => {
		if (tree.dataset.initialized) return; tree.dataset.initialized = 'true';
		const items = () => Array.from(tree.querySelectorAll('[role="treeitem"]')).filter((item) => !item.closest('[role="group"][hidden]'));
		const select = (item, focus = true) => { items().forEach((node)=>{node.tabIndex=node===item?0:-1;node.setAttribute('aria-selected',String(node===item));});if(focus)item.focus(); };
		tree.addEventListener('click',(event)=>{const item=event.target.closest('[role="treeitem"]');if(!item)return;select(item,false);if(item.hasAttribute('aria-expanded')){const open=item.getAttribute('aria-expanded')!=='true';item.setAttribute('aria-expanded',String(open));document.getElementById(item.getAttribute('aria-controls')).hidden=!open;}});
		tree.addEventListener('keydown',(event)=>{const item=event.target.closest('[role="treeitem"]');if(!item)return;const visible=items();const index=visible.indexOf(item);let next;
			if(event.key==='ArrowDown')next=visible[index+1]||visible[0];else if(event.key==='ArrowUp')next=visible[index-1]||visible.at(-1);else if(event.key==='Home')next=visible[0];else if(event.key==='End')next=visible.at(-1);else if(event.key==='ArrowRight'&&item.hasAttribute('aria-expanded')){if(item.getAttribute('aria-expanded')==='false'){item.click();return;}next=visible[index+1];}else if(event.key==='ArrowLeft'&&item.getAttribute('aria-expanded')==='true'){item.click();return;}else if(['Enter',' '].includes(event.key)){item.click();return;}else return;event.preventDefault();if(next)select(next);});
		const first=items()[0];if(first)select(first,false);
	});
}
document.addEventListener('DOMContentLoaded',()=>initTreeExplorers());
document.addEventListener('tabs:content-loaded',(event)=>initTreeExplorers(event.target));
