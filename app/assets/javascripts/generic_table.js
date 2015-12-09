$(function() {
    $('.delete_item').click(function(e) {
        e.preventDefault();
        if (window.confirm("Are you sure?")) {
            location.href = this.href;
        }
    });

    $('a[tooltip]').hover(function() {
        var tooltip = $(this).attr('tooltip');
        var offset = $(this).offset();

        tooltipElement = "<div style='z-index: 10; position: absolute; left: " + offset.left + "px; top: " + offset.top + "px'> SHARWIN </div>"


        $('body').append( tooltipElement );

    });

});