//html canvas config

//document.body.appendChild(canvas)

const divs = document.querySelectorAll('div.shader')

console.log(divs);

divs.forEach(div => {

    console.log(div);
    const img = div.querySelector('img');

    imagesLoaded(img, function () {
        const canvas = document.createElement('canvas')
        const sandbox = new GlslCanvas(canvas)

        div.append(canvas);
        div.classList.add('loaded');

        const sizer = function () {
            const w = img.clientWidth + 100;
            const h = img.clientHeight + 100;
            const dpi = window.devicePixelRatio;

            canvas.width = w * dpi;
            canvas.height = h * dpi;
            canvas.style.width = w + "px";
            canvas.style.height = h + "px";


        }

        let currentStrength = 1;
        let aimStrength = 1;


        fetch('fragment.glsl')
            .then(response => response.text())
            .then(frag => sandbox.load(frag))
            .then(function () {
                sandbox.setUniform("u_image", img.currentSrc);
                sandbox.setUniform("u_strength", 1.0);
                sandbox.setUniform("u_seed", Math.random() + 0.5);
                sandbox.setUniform('u_dpi', window.devicePixelRatio);

            })
            .then(function () {
                const observer = new IntersectionObserver(entries => {
                    entries.forEach(entry => {
                        if (entry.intersectionRatio > 0) {
                            aimStrength = 0;
                        } else {
                            aimStrength = 3;
                        }
                    })
                }, {
                    treshold: [0.0, 0.01, 1.0]
                });
                observer.observe(img);
            });

        sizer();
        window.addEventListener('resize', function () {
            sizer();
        });

        const animate = function () {

            const diff = aimStrength - currentStrength;
            currentStrength += diff * 0.03;
            console.log(currentStrength)

            sandbox.setUniform('u_strength', currentStrength)

            requestAnimationFrame(animate)

        };

        animate();


    })

})

//set up glsl canvas


document.ontouchmove = ({touches}) => {
    const touch = [touches[0].clientX, touches[0].clientY]
    console.log(touch)


};
