Shader "Holistic/PackedPractice"{// cho biet ten shader va noi cho unity se de no o dau ->  co the tim thay tren material inspector
	Properties{
		// no cung co nhung editor formatting rieng de quyet dinh no se show up nhu the nao tren inspector
		//_myNormal("Exemple Normal", Color) = (1,1,1,1)
		_myColour("Exemple Colour", Color) = (1,1,1,1)
		
	} 

	SubShader{ //shader processing code
		CGPROGRAM// bat dau cua subshader


			//trong truong hop nay ten cua ham chi ra raang day la surface shader, cung voi do la loai anh sang muon su dung(o day la Lambert)
			// dong thoi the hien ca ten cua shader function
			#pragma surface surf Lambert //bat dau bawng #pragma de chi thi cho unity biet code se duoc su sung nhu the nao
			struct Input {//input data tu model's mesh (vertices,normals,uvs,...) 
			//khai bao nhung inputdata se duoc yeu cai boi ham viet
				float2 uvMainText;
			};
			fixed4 _myColour; // de truy cap vao properties da tao can phai, list lai chung va kieu du lieu ma chung luu tru
			

			// shader function lay nhung input structure da khai bao giong nhu mot cau truc da duoc xac dinh. duoc thay doi trong ham
			//Output structure thay đổi phụ thuộc vào model ánh sáng sử dụng
			//trong truong hop nay lighting la Lambert va theo do output la surfaceoutput 
			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = _myColour.rgb;//Thay doi truong Albedo trong surfaceOutput bang myColor da declare
				o.Alpha = _myColour.w;
				
			}

		ENDCG// ket thuc cua subshader

	}
	
	FallBack "Diffuse" //fallback function
}