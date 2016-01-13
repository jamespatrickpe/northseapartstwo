//Validates if email already exists in Database
window.Parsley.addAsyncValidator('validate-email', function (xhr)
{
    //alert(xhr.status);
    var obj = $.parseJSON(xhr.responseText);
    var emailField = $("#email").parsley();
    if (obj['exists'] == false)
    {
        window.ParsleyUI.removeError(emailField, "myCustomError");
        return true;
    }
    else if (obj['exists'] == true)
    {
        window.ParsleyUI.removeError(emailField, "myCustomError");
        window.ParsleyUI.addError(emailField, "myCustomError", 'Email already exists');
        return false;
    }
    else
    {
        window.ParsleyUI.addError(emailField, "myCustomError", 'Cannot Connect to Database');
        return false;
    }
}, '/application/check_email_exists');

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
}, '/application/check_unique_holiday_date');