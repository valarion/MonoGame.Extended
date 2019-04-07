// Vertex shader input structures.

struct VertexShaderInputPosition
{
    float4 Position : SV_Position;
};

struct VertexShaderInputPositionColor
{
    float4 Position : SV_Position;
    float4 Color : COLOR;
};

struct VertexShaderInputPositionTexture
{
    float4 Position : SV_Position;
    float2 TextureCoordinate : TEXCOORD0;
};

struct VertexShaderInputPositionColorTexture
{
    float4 Position : SV_Position;
	float4 Color : COLOR;
    float2 TextureCoordinate : TEXCOORD0;
};

// Vertex shader output structures.

struct VertexShaderOutputPosition
{
    float4 Position : SV_Position;
    float4 FragmentPosition : TEXCOORD1;
};

struct VertexShaderOutputPositionColor
{
    float4 Position : SV_Position;
    float4 Color : COLOR0;
    float4 FragmentPosition : TEXCOORD1;
};

struct VertexShaderOutputPositionTexture
{
    float4 Position : SV_Position;
    float2 TextureCoordinate : TEXCOORD0;
    float4 FragmentPosition : TEXCOORD1;
};

struct VertexShaderOutputPositionColorTexture
{
    float4 Position : SV_Position;
    float4 Color : COLOR0;
    float2 TextureCoordinate : TEXCOORD0;
    float4 FragmentPosition : TEXCOORD1;
};

// Fragment shader ouput structures.

struct FragmentShaderOutput
{
    float4 Color : SV_Target0;
    float Depth : SV_Depth;
};
