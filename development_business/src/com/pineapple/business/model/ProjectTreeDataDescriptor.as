package com.pineapple.business.model
{
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.controls.treeClasses.DefaultDataDescriptor;
	
	public class ProjectTreeDataDescriptor extends DefaultDataDescriptor
	{
		public function ProjectTreeDataDescriptor()
		{
			super();
		}
		
		override public function hasChildren(node:Object, model:Object=null):Boolean
		{
			return node != null && node.children != null && (node.children as ArrayCollection) != null && (node.children as ArrayCollection).length > 0;
		}
		
		override public function isBranch(node:Object, model:Object=null):Boolean
		{
			return hasChildren(node, model);
		}
		
		override public function getData(node:Object, model:Object=null):Object
		{
			return node;
		}
		
	}
}