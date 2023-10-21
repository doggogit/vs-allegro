#pragma header

uniform float redMultiplier;
uniform float greenMultiplier;
uniform float blueMultiplier;

void main() {
    vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
    // if ((color.r+color.g+color.b) * .130718954 > .27 && color.r - color.g > .004 && color.g - color.b > .05) {
    //     color.rgb *= .4;
    // }
    color.rgb = (color.rgb + vec3(redMultiplier, greenMultiplier, blueMultiplier)) * .6 * color.a;
    gl_FragColor = color;
}