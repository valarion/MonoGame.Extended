#include "Macros.fxh"
#include "StructuresWithDepth.fxh"

DECLARE_TEXTURE(Texture, 0);

BEGIN_CONSTANTS

float4 DiffuseColor = float4(1, 1, 1, 1);

MATRIX_CONSTANTS

float4x4 WorldViewProjection _vs(c0) _cb(c0);

END_CONSTANTS

VertexShaderOutputPosition VertexShaderFunctionPosition(VertexShaderInputPosition input)
{
	VertexShaderOutputPosition output;
    output.Position = mul(input.Position, WorldViewProjection);
    output.FragmentPosition = output.Position;
	return output;
}

float4 PixelShaderFunctionPosition(VertexShaderOutputPosition input) : SV_Target0
{
	return DiffuseColor;
}

VertexShaderOutputPositionTexture VertexShaderFunctionPositionTexture(VertexShaderInputPositionTexture input)
{
	VertexShaderOutputPositionTexture output;
    output.Position = mul(input.Position, WorldViewProjection);
    output.FragmentPosition = output.Position;
	output.TextureCoordinate = input.TextureCoordinate;
	return output;
}

FragmentShaderOutput PixelShaderFunctionPositionTexture(VertexShaderOutputPositionTexture input)
{
    FragmentShaderOutput output;
    output.Color = SAMPLE_TEXTURE(Texture, input.TextureCoordinate) * DiffuseColor;
    output.Depth = output.Color.a == 0 ? 100000 : (input.FragmentPosition.z / input.FragmentPosition.w);
    return output;
}

VertexShaderOutputPositionColor VertexShaderFunctionPositionColor(VertexShaderInputPositionColor input)
{
	VertexShaderOutputPositionColor output;
    output.Position = mul(input.Position, WorldViewProjection);
    output.FragmentPosition = output.Position;
	output.Color = input.Color;
	return output;
}

float4 PixelShaderFunctionPositionColor(VertexShaderOutputPositionColor input) : SV_Target0
{
	return input.Color * DiffuseColor;
}

VertexShaderOutputPositionColorTexture VertexShaderFunctionPositionColorTexture(VertexShaderInputPositionColorTexture input)
{
	VertexShaderOutputPositionColorTexture output;
    output.Position = mul(input.Position, WorldViewProjection);
    output.FragmentPosition = output.Position;
	output.Color = input.Color;
	output.TextureCoordinate = input.TextureCoordinate;
	return output;
}

float4 PixelShaderFunctionPositionColorTexture(VertexShaderOutputPositionColorTexture input) : SV_Target0
{
	float4 textureColor = SAMPLE_TEXTURE(Texture, input.TextureCoordinate);
	return textureColor * input.Color * DiffuseColor;
}

TECHNIQUE(Position, VertexShaderFunctionPosition, PixelShaderFunctionPosition);
TECHNIQUE(PositionTexture, VertexShaderFunctionPositionTexture, PixelShaderFunctionPositionTexture);
TECHNIQUE(PositionColor, VertexShaderFunctionPositionColor, PixelShaderFunctionPositionColor);
TECHNIQUE(PositionColorTexture, VertexShaderFunctionPositionColorTexture, PixelShaderFunctionPositionColorTexture);