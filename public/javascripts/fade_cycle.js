function fadeCycle(_dom, _timeout, _transition)
{
    var vthis = this;
    this.dom = _dom;
    this.timeout = _timeout;
    this.transition = _transition;

    this.elems = this.dom.children('.diapo');
    this.current = 0;
    this.max = this.elems.length;
    this.elems.each(function(i) {
        if (i)
        {
            $(this).hide();
        }
    });

    this.nextPicture = function()
    {
        vthis.elems.eq(vthis.current).fadeOut(vthis.transition);
        vthis.current++;
        if (vthis.current == vthis.max)
        {
            vthis.current = 0;
        }
        vthis.elems.eq(vthis.current).fadeIn(vthis.transition);
    };

    this.interval = setInterval(this.nextPicture, this.timeout);
}