#ifdef GL_ES
precision highp float;
#endif

uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
uniform vec3 spectrum;

uniform sampler2D texture0;
uniform sampler2D texture1;
uniform sampler2D texture2;
uniform sampler2D texture3;
uniform sampler2D prevFrame;
uniform sampler2D prevPass;

varying vec3 v_normal;
varying vec2 v_texcoord;

void main(void)
{
    vec2 uv = -1.0 + 2.0 * v_texcoord;

    vec4 color1 = vec4(1.0, 0.0, 0.0, 1.0);
    vec4 color2 = vec4(0.0, 0.0, 1.0, 1.0);

    float f = smoothstep(0.0, 2.0, length(uv));

    vec4 color = mix(color1, color2, f);


    gl_FragColor = color;
}