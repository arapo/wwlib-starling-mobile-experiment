package
{
    import flash.display.Bitmap;

    public class AssetEmbeds_1x
    {
        // Bitmaps
        
        //[Embed(source = "../media/textures/1x/background_wht.png")]
        //public static const Background:Class;
		
        //[Embed(source = "../media/textures/1x/App_SullivanSnail_480.png")]
        //public static const Foreground:Class;
        
        [Embed(source = "../media/textures/1x/starling_sheet.png")]
        public static const StarlingSheet:Class;
        
        [Embed(source = "../media/textures/1x/starling_round.png")]
        public static const StarlingRound:Class;
        
        [Embed(source = "../media/textures/1x/starling_front.png")]
        public static const StarlingFront:Class;
        
        [Embed(source = "../media/textures/1x/logo.png")]
        public static const Logo:Class;
        
        [Embed(source = "../media/textures/1x/button_back.png")]
        public static const ButtonBack:Class;
        
        [Embed(source = "../media/textures/1x/button_big.png")]
        public static const ButtonBig:Class;
        
        [Embed(source = "../media/textures/1x/button_normal.png")]
        public static const ButtonNormal:Class;
        
        [Embed(source = "../media/textures/1x/button_square.png")]
        public static const ButtonSquare:Class;
        
        [Embed(source = "../media/textures/1x/benchmark_object.png")]
        public static const BenchmarkObject:Class;
        
		/*
        [Embed(source = "../media/textures/1x/brush.png")]
        public static const Brush:Class;
		
		[Embed(source = "../media/textures/1x/BrushCrayon1x.png")]
        public static const BrushCrayon1x:Class;
		
		[Embed(source = "../media/textures/1x/BrushCircle1x.png")]
        public static const BrushCircle1x:Class;
		
		[Embed(source = "../media/textures/1x/BrushCircleSoft1x.png")]
        public static const BrushCircleSoft1x:Class;
		
		[Embed(source = "../media/textures/1x/BrushCalligraphy1x.png")]
        public static const BrushCalligraphy1x:Class;
		
		[Embed(source = "../media/textures/1x/menu_color.png")]
        public static const MenuColor:Class;
		
		[Embed(source = "../media/textures/1x/menu_brush.png")]
        public static const MenuBrush:Class;
		
		//[Embed(source = "../media/textures/1x/menu_scene.png")]
        //public static const MenuBrush:Class;
		
		//[Embed(source = "../media/textures/1x/menu_share.png")]
        //public static const MenuBrush:Class;
        */
		
        // Compressed textures
        
        [Embed(source = "../media/textures/1x/compressed_texture.atf", mimeType="application/octet-stream")]
        public static const CompressedTexture:Class;
        
        // Texture Atlas
        
        [Embed(source="../media/textures/1x/atlas.xml", mimeType="application/octet-stream")]
        public static const AtlasXml:Class;
        
        [Embed(source="../media/textures/1x/atlas.png")]
        public static const AtlasTexture:Class;
        
        // Bitmap Fonts
        
        [Embed(source="../media/fonts/1x/desyrel.fnt", mimeType="application/octet-stream")]
        public static const DesyrelXml:Class;
        
        [Embed(source = "../media/fonts/1x/desyrel.png")]
        public static const DesyrelTexture:Class;
    }
}