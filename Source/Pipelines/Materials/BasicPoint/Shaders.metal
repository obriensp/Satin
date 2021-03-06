#include "../../Library/Shapes.metal"

vertex VertexData basicPointVertex(Vertex in[[stage_in]],
                 constant VertexUniforms &vertexUniforms[[buffer(VertexBufferVertexUniforms)]],
                 constant BasicPointUniforms &uniforms[[buffer(VertexBufferMaterialUniforms)]]) {
    VertexData out;
    out.position = vertexUniforms.projectionMatrix * vertexUniforms.modelViewMatrix * in.position;
    out.normal = normalize(vertexUniforms.normalMatrix * in.normal);
    out.uv = in.uv;
    out.pointSize = uniforms.pointSize;
    return out;
}

fragment float4 basicPointFragment(
    VertexData in[[stage_in]],
    const float2 puv [[point_coord]],
    constant BasicPointUniforms &uniforms[[buffer(FragmentBufferMaterialUniforms)]])
{
    const float2 uv = 2.0 * puv - 1.0;
    float result = Circle( uv, 1.0 );
    result = smoothstep( 0.1, 0.0 - fwidth( result ), result );
    return float4( uniforms.color.rgb, uniforms.color.a * result );
}
