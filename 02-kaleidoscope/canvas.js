const canvas = document.querySelector('div.canvas-holder canvas')
const sandbox = new GlslCanvas(canvas)

const calcSize = function() {
    let ww = window.innerWidth
    let wh = window.innerHeight
    let dpi = window.devicePixelRatio

    let size = Math.max(ww + 200, wh)

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

//sandbox.load("void main() { gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);}")

sandbox.setUniform('image', 'artwork1.jpeg');