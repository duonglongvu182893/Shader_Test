Shader "Holistic/HelloShader"{// cho biet ten shader va noi cho unity se de no o dau ->  co the tim thay tren material inspector
	Properties{
		// no cung co nhung editor formatting rieng de quyet dinh no se show up nhu the nao tren inspector
		_myColour("Exemple Colour", Color) = (1,1,1,1) //Declare  properties 
	} //noi khai bao cac truong de su dung nhu cac bien trnong subshader

	SubShader{ //shader processing code
		CGPROGRAM// bat dau cua subshader


			//trong truong hop nay ten cua ham chi ra raang day la surface shader, cung voi do la loai anh sang muon su dung
			#pragma surface surf Lambert //bat dau bawng #pragma de chi thi cho unity biet code se duoc su sung nhu the nao
			struct Input {//input data tu model's mesh (vertices,normals,uvs,...) 
			//khai bao nhung inputdata se duoc yeu cai boi ham viet
				float2 uvMainText;
			};
			fixed4 _myColour; // de truy cap vao properties da tao can phai, list lai chung va kieu du lieu ma chung luu tru
			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = _myColour.rgb;
			}

		ENDCG// ket thuc cua subshader

	}
	
	FallBack "Diffuse" //fallback function
}