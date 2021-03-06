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
package org.apache.royale.charts.supportClasses
{	
	import org.apache.royale.charts.core.IChartSeries;
	import org.apache.royale.graphics.IStroke;
	import org.apache.royale.svg.Path;
	import org.apache.royale.core.DataItemRenderer;
	
	/**
	 *  The LineSegmentItemRenderer class draws a line between the vertices of a LineSeries. 
	 *  
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.0
	 */
	public class LineSegmentItemRenderer extends DataItemRenderer implements ILineSegmentItemRenderer
	{
		public function LineSegmentItemRenderer()
		{
			super();
		}
		
		private var _series:IChartSeries;
		
		/**
		 *  The series to which this itemRenderer instance belongs. Or, the series
		 *  being presented.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get series():IChartSeries
		{
			return _series;
		}
		public function set series(value:IChartSeries):void
		{
			_series = value;
		}
				
		private var _points:Array;
		
		/**
		 *  The points of the vertices. 
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get points():Array
		{
			return _points;
		}
		public function set points(value:Array):void
		{
			_points = value;
			drawLine();
		}
		
		private var _stroke:IStroke;
		
		public function get stroke():IStroke
		{
			return _stroke;
		}
		public function set stroke(value:IStroke):void
		{
			_stroke = value;
			drawLine();
		}
		
		private var path:Path;
		
		/**
		 *  @copy org.apache.royale.supportClasses.UIItemRendererBase#data
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		override public function set data(value:Object):void
		{
			super.data = value;	
		}
		override public function get data():Object
		{
			return super.data;
		}
		
		/**
		 *  The name of the field containing the value for the Y axis. This is not implemented by this class.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get yField():String
		{
			return null;
		}
		public function set yField(value:String):void
		{
		}
		
		/**
		 *  The name of the field containing the value for the X axis. This is not implemented by this class.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get xField():String
		{
			return null;
		}
		public function set xField(value:String):void
		{
		}
		
		private var _fillColor:uint;
		
		/**
		 *  The color used to fill the interior of the box.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.0
		 */
		public function get fillColor():uint
		{
			return _fillColor;
		}
		public function set fillColor(value:uint):void
		{
			_fillColor = value;
		}
		
		/**
		 *  @private
		 */
		protected function drawLine():void
		{
			var needsAddElement:Boolean = false;
			
			if (points != null)
			{
				if (path == null) {
					path = new Path();
					needsAddElement = true;
				}
				
				path.stroke = stroke;
				path.fill = null;
				
				var pathString:String = "";
				
				for (var i:int=0; i < points.length; i++) {
					var point:Object = points[i];
					if (i == 0) pathString += "M "+point.x+" "+point.y+" ";
					else pathString += "L "+point.x+" "+point.y+" ";
				}
				
				path.x = 0;
				path.y = 0;
				path.data = pathString;
				
				if (needsAddElement) {
					addElement(path);
				}
			}
		}
	}
}
