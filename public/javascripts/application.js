function graphON(graphName) {
        off_on=eval(graphName + "s.src");
        document.images[graphName].src=off_on;
    }
function graphOFF(graphName) {
        on_off=eval(graphName + ".src");
        document.images[graphName].src=on_off;
    }
