shader_type canvas_item;

/** 
 * flash_color: The color to blend with the original texture color.
 * flash_modifier: How strongly we blend flash_color with the original color (0 = none, 1 = full).
 */
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float flash_modifier : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    // Retrieve the original pixel color from the texture
    vec4 original_color = texture(TEXTURE, UV);

    // Blend the original color's rgb with flash_color's rgb based on flash_modifier
    vec3 blended_rgb = mix(original_color.rgb, flash_color.rgb, flash_modifier);

    // Keep the original texture's alpha
    COLOR = vec4(blended_rgb, original_color.a);
}
