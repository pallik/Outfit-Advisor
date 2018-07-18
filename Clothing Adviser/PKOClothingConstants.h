//
//  PKOClothingConstants.h
//  ClothingProbabilities
//
//  Created by Pavol Kominak on 16/03/15.
//  Copyright (c) 2015 Pavol Kominak. All rights reserved.
//

typedef NS_ENUM(NSUInteger, PKOGenderType) {
	PKOGenderTypeMale,
	PKOGenderTypeFemale
};
static inline NSString * NSStringFromPKOGenderType(PKOGenderType genderType)
{
	static NSString *strings[] = {@"male", @"female"};
	return strings[genderType];
}



typedef NS_ENUM(NSUInteger, PKODressCode) {
	PKODressCodeSportswear,
	PKODressCodeCasual,
	PKODressCodeBusinessCasual,
	PKODressCodeBusiness
};
static inline NSString * NSStringFromPKODressCode(PKODressCode dressCode)
{
	static NSString *strings[] = {@"sportswear", @"casual", @"business_casual", @"business"};
	return strings[dressCode];
}



typedef NS_ENUM(NSUInteger, PKOBodyPart) {
	PKOBodyPartChest1, //Chest
	PKOBodyPartChest2, //Chest
	PKOBodyPartChest3, //Chest
	PKOBodyPartHip, //Leg
	PKOBodyPartFoot, //Foot
	PKOBodyPartLeg, //Leg
	PKOBodyPartNeck, //Accessories
	PKOBodyPartHair, //Head
	PKOBodyPartEar, //Accessories
	PKOBodyPartWristR, //Accessories
	PKOBodyPartWristL, //Accessories
	PKOBodyPartWaist, //Accessories
	PKOBodyPartEye, //Accessories
};
static inline NSUInteger PKOBodyPartSize()
{
	return 13;
}



typedef NS_ENUM(NSUInteger, PKOClothingCategory) {
	PKOClothingCategoryNone, //0
	PKOClothingCategoryCasualShirt, //Chest
	PKOClothingCategoryDressShirt,
	PKOClothingCategoryTShirt,
	PKOClothingCategorySleeveless,
	PKOClothingCategoryDress,
	PKOClothingCategoryBlouse,
	PKOClothingCategoryLongTShirt,
	PKOClothingCategoryTank,
	PKOClothingCategorySweater,
	PKOClothingCategoryVest, //10
	PKOClothingCategoryTop,
	PKOClothingCategoryHoodie,
	PKOClothingCategoryJacket,
	PKOClothingCategorySuit,
	PKOClothingCategoryOpenSweater, //Chest
	PKOClothingCategorySportPants, //Legs
	PKOClothingCategoryCasualPants,
	PKOClothingCategoryDressPants,
	PKOClothingCategoryJeans,
	PKOClothingCategoryShorts, //20
	PKOClothingCategoryDressSkirt,
	PKOClothingCategorySkirt, //Legs
	PKOClothingCategoryDressShoes, //Feet
	PKOClothingCategorySportShoes,
	PKOClothingCategoryCasualShoes,
	PKOClothingCategorySlippers,
	PKOClothingCategoryBoots, //Feet
	PKOClothingCategoryLegging, //Legs
	PKOClothingCategorySock, //Feet
	PKOClothingCategoryTie, //30 //Accessories
	PKOClothingCategoryBowTie,
	PKOClothingCategoryScarf, // Head
	PKOClothingCategoryNecklace, //Accessories
	PKOClothingCategoryCasualHat, //Head
	PKOClothingCategoryDressHat,
	PKOClothingCategoryHeadWrap,
	PKOClothingCategoryEarRings, //Accessories
	PKOClothingCategoryWatch,
	PKOClothingCategoryBracelet,
	PKOClothingCategoryBelt, //40
	PKOClothingCategoryGlasses,
	PKOClothingCategorySunGlasses
};
static inline NSString *NSStringFromPKOClothingCategory(PKOClothingCategory clothingCategory)
{
	switch (clothingCategory) {
		case PKOClothingCategoryNone:
			return @"None";
			break;
		case PKOClothingCategoryCasualShirt:
			return @"Casual shirts";
			break;
		case PKOClothingCategoryDressShirt:
			return @"Dress shirts";
			break;
		case PKOClothingCategoryTShirt:
			return @"T-shirts";
			break;
		case PKOClothingCategorySleeveless:
			return @"Sleeveless";
			break;
		case PKOClothingCategoryDress:
			return @"Dresses";
			break;
		case PKOClothingCategoryBlouse:
			return @"Blouses";
			break;
		case PKOClothingCategoryLongTShirt:
			return @"Long t-shirts";
			break;
		case PKOClothingCategoryTank:
			return @"Tanks";
			break;
		case PKOClothingCategorySweater:
			return @"Sweaters";
			break;
		case PKOClothingCategoryVest:
			return @"Vests";
			break;
		case PKOClothingCategoryTop:
			return @"Tops";
			break;
		case PKOClothingCategoryHoodie:
			return @"Hoodies";
			break;
		case PKOClothingCategoryJacket:
			return @"Jackets";
			break;
		case PKOClothingCategorySuit:
			return @"Suits";
			break;
		case PKOClothingCategoryOpenSweater:
			return @"Open sweaters";
			break;
		case PKOClothingCategorySportPants:
			return @"Sport pants";
			break;
		case PKOClothingCategoryCasualPants:
			return @"Casual pants";
			break;
		case PKOClothingCategoryDressPants:
			return @"Dress pants";
			break;
		case PKOClothingCategoryJeans:
			return @"Jeans";
			break;
		case PKOClothingCategoryShorts:
			return @"Shorts";
			break;
		case PKOClothingCategoryDressSkirt:
			return @"Dress skirts";
			break;
		case PKOClothingCategorySkirt:
			return @"Skirts";
			break;
		case PKOClothingCategoryDressShoes:
			return @"Dress shoes";
			break;
		case PKOClothingCategorySportShoes:
			return @"Sport shoes";
			break;
		case PKOClothingCategoryCasualShoes:
			return @"Casual shoes";
			break;
		case PKOClothingCategorySlippers:
			return @"Slippers";
			break;
		case PKOClothingCategoryBoots:
			return @"Boots";
			break;
		case PKOClothingCategoryLegging:
			return @"Leggings";
			break;
		case PKOClothingCategorySock:
			return @"Socks";
			break;
		case PKOClothingCategoryTie:
			return @"Ties";
			break;
		case PKOClothingCategoryBowTie:
			return @"Bow ties";
			break;
		case PKOClothingCategoryScarf:
			return @"Scarfs";
			break;
		case PKOClothingCategoryNecklace:
			return @"Necklaces";
			break;
		case PKOClothingCategoryCasualHat:
			return @"Casual hats";
			break;
		case PKOClothingCategoryDressHat:
			return @"Dress hats";
			break;
		case PKOClothingCategoryHeadWrap:
			return @"Head wraps";
			break;
		case PKOClothingCategoryEarRings:
			return @"Ear rings";
			break;
		case PKOClothingCategoryWatch:
			return @"Watches";
			break;
		case PKOClothingCategoryBracelet:
			return @"Bracelets";
			break;
		case PKOClothingCategoryBelt:
			return @"Belts";
			break;
		case PKOClothingCategoryGlasses:
			return @"Glasses";
			break;
		case PKOClothingCategorySunGlasses:
			return @"Sun glasses";
			break;
	}
}
static inline PKOBodyPart PKOBodyPartFromPKOClothingCategory(PKOClothingCategory clothingCategory)
{
	switch (clothingCategory) {
		case PKOClothingCategoryNone:
		case PKOClothingCategoryCasualShirt:
		case PKOClothingCategoryDressShirt:
		case PKOClothingCategoryTShirt:
		case PKOClothingCategorySleeveless:
		case PKOClothingCategoryDress:
		case PKOClothingCategoryBlouse:
			return PKOBodyPartChest1;
			break;
		case PKOClothingCategoryLongTShirt:
		case PKOClothingCategoryTank:
		case PKOClothingCategorySweater:
		case PKOClothingCategoryVest:
		case PKOClothingCategoryTop:
			return PKOBodyPartChest2;
			break;
		case PKOClothingCategoryHoodie:
		case PKOClothingCategoryJacket:
		case PKOClothingCategorySuit:
		case PKOClothingCategoryOpenSweater:
			return PKOBodyPartChest3;
			break;
		case PKOClothingCategorySportPants:
		case PKOClothingCategoryCasualPants:
		case PKOClothingCategoryDressPants:
		case PKOClothingCategoryJeans:
		case PKOClothingCategoryShorts:
		case PKOClothingCategoryDressSkirt:
		case PKOClothingCategorySkirt:
			return PKOBodyPartHip;
			break;
		case PKOClothingCategoryDressShoes:
		case PKOClothingCategorySportShoes:
		case PKOClothingCategoryCasualShoes:
		case PKOClothingCategorySlippers:
		case PKOClothingCategoryBoots:
			return PKOBodyPartFoot;
			break;
		case PKOClothingCategoryLegging:
		case PKOClothingCategorySock:
			return PKOBodyPartLeg;
			break;
		case PKOClothingCategoryTie:
		case PKOClothingCategoryBowTie:
		case PKOClothingCategoryScarf:
		case PKOClothingCategoryNecklace:
			return PKOBodyPartNeck;
			break;
		case PKOClothingCategoryCasualHat:
		case PKOClothingCategoryDressHat:
		case PKOClothingCategoryHeadWrap:
			return PKOBodyPartHair;
			break;
		case PKOClothingCategoryEarRings:
			return PKOBodyPartEar;
			break;
		case PKOClothingCategoryWatch: //Switched for PKOBodyPartFemale vs original files (to keep same as PKOBodyPartMale)
			return PKOBodyPartWristL;
			break;
		case PKOClothingCategoryBracelet: //Switched for PKOBodyPartFemale vs original files (to keep same as PKOBodyPartMale)
			return PKOBodyPartWristR;
			break;
		case PKOClothingCategoryBelt:
			return PKOBodyPartWaist;
			break;
		case PKOClothingCategoryGlasses:
		case PKOClothingCategorySunGlasses:
			return PKOBodyPartEye;
			break;
	}
}















