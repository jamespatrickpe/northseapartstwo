window.Parsley.addAsyncValidator('unique-holiday-date', function (xhr)
{
    var obj = $.parseJSON(xhr.responseText);
    var uniqueDate = $("#holiday_date_0").parsley();
    if (obj['exists'] == false)
    {
        window.ParsleyUI.removeError(uniqueDate, "myCustomError");
        return true;
    }
    else if (obj['exists'] == true)
    {
        window.ParsleyUI.removeError(uniqueDate, "myCustomError");
        window.ParsleyUI.addError(uniqueDate, "myCustomError", 'Date for Holiday has already been taken. In case of Double Holiday please delete current Holiday and State Double Holiday in a New Form');
        return false;
    }
}, 'http://localhost:3000/human_resources/settings/holidays/check_unique_holiday_date');