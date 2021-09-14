const canvas = document.querySelector('div.canvas-holder canvas')
const sandbox = new GlslCanvas(canvas)

const images = [
    'artwork1.jpeg',
    'artwork2.jpeg',
    'artwork3.jpeg',
    'artwork4.jpeg',
    'artwork5.jpeg',
    'artwork6.jpeg',
    'artwork7.jpeg'
];

let currentImage = 1;

console.log(images[0]);



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


function updateImage() {
    sandbox.setUniform('image', `images/${images[currentImage]}`);
}

updateImage();
function handleClick() {
    currentImage = (currentImage+1) % images.length;
    updateImage();
}

window.addEventListener('click', handleClick)