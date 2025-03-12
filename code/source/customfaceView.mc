import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;

class customfaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time and date information
        var clockTime = System.getClockTime();
        
        // Get proper date information using Gregorian
        var now = Time.now();
        var info = Gregorian.info(now, Time.FORMAT_SHORT);

        // Format the time string with AM/PM
        var hour = clockTime.hour;
        var ampm = "AM";


        // Convert to 12-hour format
        if (hour >= 12) {
            ampm = "PM";
            if (hour > 12) {
                hour = hour - 12;
            }
        }

        var dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        var dayName = dayNames[info.day_of_week - 1]; 
        
        // Formated strings
        var timeString = Lang.format("$1$:$2$", [hour, clockTime.min.format("%02d")]);
        var formated_date = Lang.format("$1$/$2$", [info.month, info.day]);
        
        // Update the views
        var time_view = View.findDrawableById("HoursAndMinutes") as Text;
        time_view.setText(timeString);

        var ampm_view = View.findDrawableById("AmPm") as Text;
        ampm_view.setText(ampm);

        var date_view = View.findDrawableById("Date") as Text;
        date_view.setText(formated_date);

        var day_name_view = View.findDrawableById("DayOfTheWeek") as Text;
        day_name_view.setText(dayName);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }
}