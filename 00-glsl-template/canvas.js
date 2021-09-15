const canvas = document.querySelector('div.canvas-holder canvas')
const sandbox = new GlslCanvas(canvas)

const calcSize = function() {
    let ww = window.innerWidth
    let wh = window.innerHeight
    let dpi = window.devicePixelRatio

    let size = Math.max(ww, wh)

    canvas.width = size * dpi
    canvas.height = size * dpi
    canvas.style.width = size + 'px';
    canvas.style.height = size + 'px';
}

calcSize();

window.addEventListener("resize", function (){
    calcSize();
})

//load glsl code
fetch('fragment.glsl')
    .then(response => response.text())
   .then(text => sandbox.load(text))

function handleClick() {
}

window.addEventListener('click', handleClick)