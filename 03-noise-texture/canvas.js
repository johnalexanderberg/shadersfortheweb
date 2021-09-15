//html canvas config
const canvas = document.querySelector('div.canvas-holder canvas')

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

//glsl canvas config
const sandbox = new GlslCanvas(canvas)

fetch('fragment.glsl')
    .then(response => response.text())
   .then(text => sandbox.load(text))

//On click
function handleClick() {
}

window.addEventListener('click', handleClick)