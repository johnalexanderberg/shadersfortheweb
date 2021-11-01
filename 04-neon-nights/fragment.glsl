#ifdef GL_ES
precision highp float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

uniform sampler2D u_image;
uniform float u_strength;
uniform float u_color;
uniform float u_seed;
uniform float u_dpi;

varying vec2 v_texcoord;

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

mat2 rotation2d(float angle) {
    float s = sin(angle);
    float c = cos(angle);

    return mat2(
    c, -s,
    s, c
    );
}


vec4 sampleColor(vec2 uv){

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0){
        return vec4(0.0);
    }

    return texture2D(u_image, uv);
}

void main(void)
{

    vec2 uv = (gl_FragCoord.xy-(50.0 * u_dpi)) / (u_resolution.xy - (100.0 * u_dpi));

    float speed = u_time/2.0*u_seed;

    vec2 distortion = 0.01 * pow(u_strength, 0.8)  * u_seed * sin(u_time +uv.x *u_resolution.x/32.0*sin(u_time/25.0)+sin(u_time/9.0)*12.0 + uv.y * 1.5) * vec2(
    sin(speed+uv.x * 8.0),
    sin(u_time +uv.x *8.0 + uv.y * 8.0)
    );


    vec2 distortion2 = 0.01 * pow(u_strength, 0.8) * u_seed * vec2(
    sin(speed/3.0+uv.x * 1.0 + uv.y * 8.0),
    sin(u_time +uv.x *3.0 + uv.y * 1.5)
    );


    distortion *= mix(0.95, 1.05,rand(uv));
    distortion2 *= mix(0.95, 1.05,rand(uv));

    vec4 blackChannel = sampleColor(uv + distortion*0.2);
    blackChannel.r = 0.0;
    blackChannel.g = 0.0;
    blackChannel.b = 0.0;


    vec4 redChannel = sampleColor(uv  + distortion * rotation2d(1.0 * u_seed ));
    redChannel.g = 0.0;
    redChannel.b = 0.0;
    redChannel.a = redChannel.r;

    vec4 greenChannel = sampleColor(uv - distortion/3.0 * u_seed  * rotation2d(2.0 * u_seed ));
    greenChannel.r = 0.0;
    greenChannel.b = 0.0;
    greenChannel.a = greenChannel.g;

    vec4 blueChannel = sampleColor(uv - distortion/32.0 * u_seed  + distortion2 * rotation2d(3.0 * u_seed ));
    blueChannel.r = 0.0;
    blueChannel.g = 0.0;
    blueChannel.a = blueChannel.b;

    vec4 color = blackChannel + redChannel + greenChannel + blueChannel;

    gl_FragColor = color;
}
