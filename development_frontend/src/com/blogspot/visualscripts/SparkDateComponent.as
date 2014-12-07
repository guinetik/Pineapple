package com.blogspot.visualscripts {

import flash.events.Event;
import mx.collections.IList;
import mx.events.CollectionEvent;
import spark.components.Label;
import spark.components.List;
import spark.events.IndexChangeEvent;
/** 
 * Spark only component for displaying and selecting dates.
 * Most code from http://blogs.adobe.com/aharui/2010/01/spark_datefield_and_colorpicke.html
 * Copyright:
 * None, but i'd be happy to see where you used it, or if you could improve it.
 * Matyas Forian Szabo, 2011
 * */
public class SparkDateComponent extends List{

    private var calendarIList:CalendarIList = new CalendarIList();
	[SkinPart(required="false")] public var YearMonthLabel:Label;
	[SkinPart(required="false")] public var labelDisplay:Label; // only used by DateField
	private var _selectedDate:Date;
	
    public function SparkDateComponent() {
        super();
        super.dataProvider = calendarIList;
        super.dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, collectionChangeHandler);
		addEventListener(IndexChangeEvent.CHANGE,onSelectionChange);
        var d:Date = new Date();
        calendarIList.setMonthAndYear(d.month, d.fullYear);
    }
	// user changes the selection in the datechooser
	private function onSelectionChange(e:IndexChangeEvent):void{
		_selectedDate = CalendarIListDay(selectedItem).date;
		if (labelDisplay) {
			labelDisplay.text = _selectedDate.date+"/"+(_selectedDate.month+1)+"/"+_selectedDate.fullYear;
		}
		dispatchEvent(new Event("selectedDateChange"));
	}
    
	[Bindable(event="selectedDateChange")]
    public function get selectedDate():Date{
        return _selectedDate;
    }
	
	// selectedDate changes externally
    public function set selectedDate(value:Date):void {
		_selectedDate = value;
		dispatchEvent(new Event("selectedDateChange"));
		if (value == null) {
			if (labelDisplay) labelDisplay.text = "";
			var d:Date = new Date();
			calendarIList.setMonthAndYear(d.month, d.fullYear);
			return;
		}
        calendarIList.setMonthAndYear(value.month, value.fullYear);
		if (labelDisplay) {
			labelDisplay.text = _selectedDate.date+"/"+(_selectedDate.month+1)+"/"+_selectedDate.fullYear;
		}
		// select the date
        var n:int = dataProvider.length;
        for (var i:int = 0; i<n; i++) {
            if (CalendarIListDay( dataProvider.getItemAt(i) ).date.date == value.date) {
				selectedItem = dataProvider.getItemAt(i);
			}
        }
    }
    // called, if the selected month changes
    private function collectionChangeHandler(e:CollectionEvent):void{
		selectedItem = null;
		if (_selectedDate) {// if there is a selected date, try to find it on the display
			var n:int = dataProvider.length;
			for (var i:int = 0; i<n; i++) {
				if (CalendarIListDay(dataProvider.getItemAt(i)).date.date == _selectedDate.date && 
					CalendarIListDay(dataProvider.getItemAt(i)).date.month == _selectedDate.month &&
					CalendarIListDay(dataProvider.getItemAt(i)).date.fullYear == _selectedDate.fullYear ) {
					selectedItem = dataProvider.getItemAt(i);
				}
			}
		}
        if (YearMonthLabel) {
            YearMonthLabel.text = monthNames[calendarIList.month] + "   " +calendarIList.year.toString();
		}
    }
    // don't allow anyone to set our custom DP
    override public function set dataProvider(value:IList):void{
    }
    
    override protected function partAdded(partName:String, instance:Object):void{
        super.partAdded(partName, instance);
        if (instance == YearMonthLabel) {
            YearMonthLabel.text = monthNames[calendarIList.month]+"   "+calendarIList.year.toString(); 
		}
    }
	
	private static const monthNames:Vector.<String> = Vector.<String>([
		'Janeiro','Fevereiro','Março','Abril',
		'Maio','Junho','Julho','Agosto','Setembro','Outubro',
		'Novembro','Dezembro'
		]);

}

}
