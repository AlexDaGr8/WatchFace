using Toybox.WatchUi;
using Toybox.Graphics as Gfx;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;
using Toybox.ActivityMonitor;

class WatchFaceView extends WatchUi.WatchFace {

	var customFont = null;
	var typicons = null;
	var heartIcon = null;

    function onLayout(dc) {
		customFont = WatchUi.loadResource(Rez.Fonts.customFont);
		typicons = WatchUi.loadResource(Rez.Fonts.typicons22);
    }
    
    function onUpdate(dc) {
        // Set background color
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        
        var w = dc.getWidth();
        var h = dc.getHeight();
        
        
        // Get the current time
        var clockTime = System.getClockTime();

        var x = dc.getWidth() / 2;
        var y = dc.getHeight() / 5;
        // Draw Hour
        var hourStr = Lang.format("$1$", [clockTime.hour]);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
        dc.drawText(x, y, customFont, hourStr, Gfx.TEXT_JUSTIFY_RIGHT);
        
        // Draw Min
        var min = clockTime.min;
        if (min < 10) { min = "0" + min; }
        var minStr = Lang.format("$1$", [min]);
        dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_BLACK);
        dc.drawText(x, y, customFont, minStr, Gfx.TEXT_JUSTIFY_LEFT);
        
        // Get today and set position
        var today = Gregorian.info(Time.now(), Time.FORMAT_MEDIUM);
		y = dc.getHeight() - 20;
        
        // Draw Day of Week
		var dayOfWeek = Lang.format("$1$",[today.day_of_week]);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
        dc.drawText(x, y, Gfx.FONT_SMALL, dayOfWeek, Gfx.TEXT_JUSTIFY_RIGHT);
        
        // Draw Day
		var day = Lang.format(" $1$",[today.day]);
        dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_BLACK);
        dc.drawText(x, y, Gfx.FONT_SMALL, day, Gfx.TEXT_JUSTIFY_LEFT);
        
        // Battery info
        var myStats = System.getSystemStats();
        x = dc.getWidth() / 4;
        y = 30;
        
		var battery = myStats.battery;
		
        dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_BLACK);
        if (battery < 20) { 
        	dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK); 
			dc.fillRectangle(x-4, y+8, 19 * (battery/100), 11);
        }
        else {
        	dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_BLACK); 
			dc.fillRectangle(x-4, y+8, 19 * (battery/100), 11);
        }
		
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
		dc.drawRoundedRectangle(x-5, y+7, 20, 13, 2);
		dc.fillRectangle(x+15, y+10, 2, 7.7);
		
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
		dc.drawText(x+19, y, Gfx.FONT_MEDIUM, battery.format("%d") + "%", Gfx.TEXT_JUSTIFY_LEFT);
		
		
        x = dc.getWidth()-60;
        y = 30;
        
        var hrIterator = ActivityMonitor.getHeartRateHistory(1, true);
        var hr = hrIterator.next().heartRate;
       	dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_BLACK); 
		dc.drawText(x, y, Gfx.FONT_MEDIUM, Lang.format("$1$", [hr]), Gfx.TEXT_JUSTIFY_LEFT);
		
        
    }

    function onShow() {
    }
    function onHide() {
    }
    function onExitSleep() {
    }
    function onEnterSleep() {
    }

}
