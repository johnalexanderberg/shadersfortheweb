#ifdef GL_ES
precision highp float;
#endif

uniform float u_time;
uniform vec2 u_resolution;
uniform vec2 u_mouse;

varying vec2 v_texcoord;

#define NUM_OCTAVES 3

// rand noise and fbm grabbed from
// https://raw.githubusercontent.com/yiwenl/glsl-fbm/master/2d.glsl
float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

float noise(vec2 p){
    vec2 ip = floor(p);
    vec2 u = fract(p);
    u = u*u*(3.0-2.0*u);

    float res = mix(
    mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
    mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
    return res*res;
}

float fbm(vec2 x) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(x);
        x = rot * x * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

mat2 rotation2d(float angle) {
    float s = sin(angle);
    float c = cos(angle);

    return mat2(
    c, -s,
    s, c
    );
}

// hsv 2 rgb conversion
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void)
{
    vec2 uv = v_texcoord;

    float hue = u_time*0.005;

    vec3 hsv1 = vec3(hue, 0.9, 0.8);
    vec3 hsv2 = vec3(hue-0.1, 0.6, 0.7);
    vec3 hsv3 = vec3(hue, 1.0, 1.0);

    vec3 rgb1 = hsv2rgb(hsv1);
    vec3 rgb2 = hsv2rgb(hsv2);


    vec4 color1 = vec4(rgb1, 1.0);
    vec4 color2 = vec4(rgb2, 1.0);

    float grain = mix(-0.01, 0.09, rand(uv));

    //make movement for fbm
    vec2 movement = vec2(u_time * 0.002, u_time * -0.003);
    movement *= rotation2d(u_time*0.001);

    float f = fbm(uv + movement);
    f *= 10.0;
    f += grain;
    f += u_time* 0.1;
    f = fract(f);

    float mixer = smoothstep(0.0, 0.05, f) - smoothstep(0.1, 0.3, f);

    vec4 color = mix(color1, color2, mixer);


    gl_FragColor = color;
}