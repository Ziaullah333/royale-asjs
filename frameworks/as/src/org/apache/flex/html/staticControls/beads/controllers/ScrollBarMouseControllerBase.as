////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.html.staticControls.beads.controllers
{
	import flash.events.MouseEvent;
	
	import org.apache.flex.core.IBeadController;
	import org.apache.flex.core.IScrollBarModel;
	import org.apache.flex.core.IStrand;
	import org.apache.flex.events.Event;
	import org.apache.flex.events.IEventDispatcher;
	import org.apache.flex.html.staticControls.beads.IScrollBarView;

	public class ScrollBarMouseControllerBase implements IBeadController
	{
		public function ScrollBarMouseControllerBase()
		{
		}
		
		protected var sbModel:IScrollBarModel;
		protected var sbView:IScrollBarView;
		
		private var _strand:IStrand;
		
		public function get strand():IStrand
		{
			return _strand;
		}
		
		public function set strand(value:IStrand):void
		{
			_strand = value;
			sbModel = value.getBeadByType(IScrollBarModel) as IScrollBarModel;
			sbView = value.getBeadByType(IScrollBarView) as IScrollBarView;
			sbView.decrement.addEventListener(MouseEvent.CLICK, decrementClickHandler);
			sbView.increment.addEventListener(MouseEvent.CLICK, incrementClickHandler);
            sbView.decrement.addEventListener("buttonRepeat", decrementClickHandler);
            sbView.increment.addEventListener("buttonRepeat", incrementClickHandler);
			sbView.track.addEventListener(MouseEvent.CLICK, trackClickHandler);
			sbView.thumb.addEventListener(MouseEvent.MOUSE_DOWN, thumbMouseDownHandler);
		}
		
	
		protected function snap(value:Number):Number
		{
			var si:Number = sbModel.snapInterval;
			var n:Number = Math.round((value - sbModel.minimum) / si) * si + sbModel.minimum;
			if (value > 0)
			{
				if (value - n < n + si - value)
					return n;
				return n + si;
				
			}
			if (value - n > n + si - value)
				return n + si;
			return n;
		}
		
		protected function decrementClickHandler(event:Event):void
		{
			sbModel.value = snap(Math.max(sbModel.minimum, sbModel.value - sbModel.stepSize));
			IEventDispatcher(_strand).dispatchEvent(new Event("scroll"));
		}
		
		protected function incrementClickHandler(event:Event):void
		{
			sbModel.value = snap(Math.min(sbModel.maximum - sbModel.pageSize, sbModel.value + sbModel.stepSize));	
			IEventDispatcher(_strand).dispatchEvent(new Event("scroll"));
		}
		
		protected function trackClickHandler(event:MouseEvent):void
		{
		}
		
		protected function thumbMouseDownHandler(event:MouseEvent):void
		{
		}
		
	}
}