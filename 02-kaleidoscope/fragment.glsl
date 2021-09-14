precision highp float;

uniform sampler2D image;
varying vec2 v_texcoord;

void main() {
    vec2 uv = v_texcoord;
    vec4 color = vec4 (55.0, 120.0, 24.0, 255.0);

    gl_FragColor = color;
}