/*
 * Powerpoint.h
 */

#import <AppKit/AppKit.h>
#import <ScriptingBridge/ScriptingBridge.h>


@class PowerpointBaseObject, PowerpointBaseApplication, PowerpointBaseDocument, PowerpointBasicWindow, PowerpointPrintSettings, PowerpointCommandBarControl, PowerpointCommandBarButton, PowerpointCommandBarCombobox, PowerpointCommandBarPopup, PowerpointCommandBar, PowerpointDocumentProperty, PowerpointCustomDocumentProperty, PowerpointWebPageFont, PowerpointActionSetting, PowerpointAnimationBehavior, PowerpointAnimationPoint, PowerpointAnimationSettings, PowerpointApplication, PowerpointAutocorrectEntry, PowerpointAutocorrect, PowerpointBulletFormat, PowerpointColorScheme, PowerpointColorsEffect, PowerpointCommandEffect, PowerpointCustomLayout, PowerpointDefaultWebOptions, PowerpointDesign, PowerpointDocumentWindow, PowerpointEffectInformation, PowerpointEffectParameters, PowerpointEffect, PowerpointFilterEffect, PowerpointFirstLetterException, PowerpointFont, PowerpointHeaderOrFooter, PowerpointHeadersAndFooters, PowerpointHyperlink, PowerpointMaster, PowerpointMotionEffect, PowerpointNamedSlideShow, PowerpointPageSetup, PowerpointPane, PowerpointParagraphFormat, PowerpointPlaySettings, PowerpointPreferences, PowerpointPresentation, PowerpointPresenterTool, PowerpointPresenterViewWindow, PowerpointPrintOptions, PowerpointPrintRange, PowerpointPropertyEffect, PowerpointRotatingEffect, PowerpointRulerLevel, PowerpointRuler, PowerpointSaveAsMovieSettings, PowerpointScaleEffect, PowerpointSequence, PowerpointSetEffect, PowerpointSlideShowSettings, PowerpointSlideShowTransition, PowerpointSlideShowView, PowerpointSlideShowWindow, PowerpointSlide, PowerpointSoundEffect, PowerpointTabStop, PowerpointTextStyleLevel, PowerpointTextStyle, PowerpointTimeline, PowerpointTiming, PowerpointTwoInitialCapsException, PowerpointView, PowerpointWebOptions, PowerpointAdjustment, PowerpointCalloutFormat, PowerpointConnectorFormat, PowerpointFillFormat, PowerpointGlowFormat, PowerpointGradientStop, PowerpointLineFormat, PowerpointLinkFormat, PowerpointOfficeTheme, PowerpointPictureFormat, PowerpointPlaceholderFormat, PowerpointReflectionFormat, PowerpointShadowFormat, PowerpointShape, PowerpointCallout, PowerpointComment, PowerpointConnector, PowerpointLineShape, PowerpointMediaObject, PowerpointPicture, PowerpointPlaceHolder, PowerpointShapeTable, PowerpointSoftEdgeFormat, PowerpointTextBox, PowerpointTextColumn, PowerpointTextFrame, PowerpointThemeColorScheme, PowerpointThemeColor, PowerpointThemeEffectScheme, PowerpointThemeFontScheme, PowerpointThemeFont, PowerpointMajorThemeFont, PowerpointMinorThemeFont, PowerpointThreeDFormat, PowerpointWordArtFormat, PowerpointTextRange, PowerpointCharacter, PowerpointLine, PowerpointParagraph, PowerpointSentence, PowerpointTextFlow, PowerpointWord, PowerpointCell, PowerpointColumn, PowerpointRow, PowerpointTable;

enum PowerpointSavo {
	PowerpointSavoYes = 'yes ' /* Save objects now */,
	PowerpointSavoNo = 'no  ' /* Do not save objects */,
	PowerpointSavoAsk = 'ask ' /* Ask the user whether to save */
};
typedef enum PowerpointSavo PowerpointSavo;

enum PowerpointKfrm {
	PowerpointKfrmIndex = 'indx' /* keyform designating indexed access */,
	PowerpointKfrmNamed = 'name' /* keyform designating named access */,
	PowerpointKfrmId = 'ID  ' /* keyform designating access by unique identifier */
};
typedef enum PowerpointKfrm PowerpointKfrm;

enum PowerpointPPfd {
	PowerpointPPfdMacintoshPath = 'utxt' /* Maintosh path i.e. Foo:bar.txt */,
	PowerpointPPfdPosixPath = 'file' /* Posix path i.e. file:://foo/bar.txt */
};
typedef enum PowerpointPPfd PowerpointPPfd;

enum PowerpointPPff {
	PowerpointPPffSaveAsPresentation = '\000\314\000\001',
	PowerpointPPffSaveAsTemplate = '\000\314\000\005',
	PowerpointPPffSaveAsRTF = '\000\314\000\006',
	PowerpointPPffSaveAsShow = '\000\314\000\007',
	PowerpointPPffSaveAsDefault = '\000\314\000\012',
	PowerpointPPffSaveAsHTML = '\000\314\000\013',
	PowerpointPPffSaveAsMovie = '\000\314\000\014',
	PowerpointPPffSaveAsPackage = '\000\314\000\015',
	PowerpointPPffSaveAsPDF = '\000\314\000\016',
	PowerpointPPffSaveAsOpenXMLPresentation = '\000\314\000\017',
	PowerpointPPffSaveAsOpenXMLPresentationMacroEnabled = '\000\314\000\020',
	PowerpointPPffSaveAsOpenXMLShow = '\000\314\000\021',
	PowerpointPPffSaveAsOpenXMLShowMacroEnabled = '\000\314\000\022',
	PowerpointPPffSaveAsOpenXMLTemplate = '\000\314\000\023',
	PowerpointPPffSaveAsOpenXMLTemplateMacroEnabled = '\000\314\000\024',
	PowerpointPPffSaveAsOpenXMLTheme = '\000\314\000\025'
};
typedef enum PowerpointPPff PowerpointPPff;

enum PowerpointMlDs {
	PowerpointMlDsLineDashStyleUnset = '\000\222\377\376',
	PowerpointMlDsLineDashStyleSolid = '\000\223\000\001',
	PowerpointMlDsLineDashStyleSquareDot = '\000\223\000\002',
	PowerpointMlDsLineDashStyleRoundDot = '\000\223\000\003',
	PowerpointMlDsLineDashStyleDash = '\000\223\000\004',
	PowerpointMlDsLineDashStyleDashDot = '\000\223\000\005',
	PowerpointMlDsLineDashStyleDashDotDot = '\000\223\000\006',
	PowerpointMlDsLineDashStyleLongDash = '\000\223\000\007',
	PowerpointMlDsLineDashStyleLongDashDot = '\000\223\000\010',
	PowerpointMlDsLineDashStyleLongDashDotDot = '\000\223\000\011',
	PowerpointMlDsLineDashStyleSystemDash = '\000\223\000\012',
	PowerpointMlDsLineDashStyleSystemDot = '\000\223\000\013',
	PowerpointMlDsLineDashStyleSystemDashDot = '\000\223\000\014'
};
typedef enum PowerpointMlDs PowerpointMlDs;

enum PowerpointMLnS {
	PowerpointMLnSLineStyleUnset = '\000\224\377\376',
	PowerpointMLnSSingleLine = '\000\225\000\001',
	PowerpointMLnSThinThinLine = '\000\225\000\002',
	PowerpointMLnSThinThickLine = '\000\225\000\003',
	PowerpointMLnSThickThinLine = '\000\225\000\004',
	PowerpointMLnSThickBetweenThinLine = '\000\225\000\005'
};
typedef enum PowerpointMLnS PowerpointMLnS;

enum PowerpointMAhS {
	PowerpointMAhSArrowheadStyleUnset = '\000\221\377\376',
	PowerpointMAhSNoArrowhead = '\000\222\000\001',
	PowerpointMAhSTriangleArrowhead = '\000\222\000\002',
	PowerpointMAhSOpen_arrowhead = '\000\222\000\003',
	PowerpointMAhSStealthArrowhead = '\000\222\000\004',
	PowerpointMAhSDiamondArrowhead = '\000\222\000\005',
	PowerpointMAhSOvalArrowhead = '\000\222\000\006'
};
typedef enum PowerpointMAhS PowerpointMAhS;

enum PowerpointMAhW {
	PowerpointMAhWArrowheadWidthUnset = '\000\220\377\376',
	PowerpointMAhWNarrowWidthArrowhead = '\000\221\000\001',
	PowerpointMAhWMediumWidthArrowhead = '\000\221\000\002',
	PowerpointMAhWWideArrowhead = '\000\221\000\003'
};
typedef enum PowerpointMAhW PowerpointMAhW;

enum PowerpointMAhL {
	PowerpointMAhLArrowheadLengthUnset = '\000\223\377\376',
	PowerpointMAhLShortArrowhead = '\000\224\000\001',
	PowerpointMAhLMediumArrowhead = '\000\224\000\002',
	PowerpointMAhLLongArrowhead = '\000\224\000\003'
};
typedef enum PowerpointMAhL PowerpointMAhL;

enum PowerpointMFdT {
	PowerpointMFdTFillUnset = '\000c\377\376',
	PowerpointMFdTFillSolid = '\000d\000\001',
	PowerpointMFdTFillPatterned = '\000d\000\002',
	PowerpointMFdTFillGradient = '\000d\000\003',
	PowerpointMFdTFillTextured = '\000d\000\004',
	PowerpointMFdTFillBackground = '\000d\000\005',
	PowerpointMFdTFillPicture = '\000d\000\006'
};
typedef enum PowerpointMFdT PowerpointMFdT;

enum PowerpointMGdS {
	PowerpointMGdSGradientUnset = '\000d\377\376',
	PowerpointMGdSHorizontalGradient = '\000e\000\001',
	PowerpointMGdSVerticalGradient = '\000e\000\002',
	PowerpointMGdSDiagonalUpGradient = '\000e\000\003',
	PowerpointMGdSDiagonalDownGradient = '\000e\000\004',
	PowerpointMGdSFromCornerGradient = '\000e\000\005',
	PowerpointMGdSFromTitleGradient = '\000e\000\006',
	PowerpointMGdSFromCenterGradient = '\000e\000\007'
};
typedef enum PowerpointMGdS PowerpointMGdS;

enum PowerpointMGCt {
	PowerpointMGCtGradientTypeUnset = '\003\357\377\376',
	PowerpointMGCtSingleShadeGradientType = '\003\360\000\001',
	PowerpointMGCtTwoColorsGradientType = '\003\360\000\002',
	PowerpointMGCtPresetColorsGradientType = '\003\360\000\003',
	PowerpointMGCtMultiColorsGradientType = '\003\360\000\004'
};
typedef enum PowerpointMGCt PowerpointMGCt;

enum PowerpointMxtT {
	PowerpointMxtTTextureTypeTextureTypeUnset = '\003\360\377\376',
	PowerpointMxtTTextureTypePresetTexture = '\003\361\000\001',
	PowerpointMxtTTextureTypeUserDefinedTexture = '\003\361\000\002'
};
typedef enum PowerpointMxtT PowerpointMxtT;

enum PowerpointMPzT {
	PowerpointMPzTPresetTextureUnset = '\000e\377\376',
	PowerpointMPzTTexturePapyrus = '\000f\000\001',
	PowerpointMPzTTextureCanvas = '\000f\000\002',
	PowerpointMPzTTextureDenim = '\000f\000\003',
	PowerpointMPzTTextureWovenMat = '\000f\000\004',
	PowerpointMPzTTextureWaterDroplets = '\000f\000\005',
	PowerpointMPzTTexturePaperBag = '\000f\000\006',
	PowerpointMPzTTextureFishFossil = '\000f\000\007',
	PowerpointMPzTTextureSand = '\000f\000\010',
	PowerpointMPzTTextureGreenMarble = '\000f\000\011',
	PowerpointMPzTTextureWhiteMarble = '\000f\000\012',
	PowerpointMPzTTextureBrownMarble = '\000f\000\013',
	PowerpointMPzTTextureGranite = '\000f\000\014',
	PowerpointMPzTTextureNewsprint = '\000f\000\015',
	PowerpointMPzTTextureRecycledPaper = '\000f\000\016',
	PowerpointMPzTTextureParchment = '\000f\000\017',
	PowerpointMPzTTextureStationery = '\000f\000\020',
	PowerpointMPzTTextureBlueTissuePaper = '\000f\000\021',
	PowerpointMPzTTexturePinkTissuePaper = '\000f\000\022',
	PowerpointMPzTTexturePurpleMesh = '\000f\000\023',
	PowerpointMPzTTextureBouquet = '\000f\000\024',
	PowerpointMPzTTextureCork = '\000f\000\025',
	PowerpointMPzTTextureWalnut = '\000f\000\026',
	PowerpointMPzTTextureOak = '\000f\000\027',
	PowerpointMPzTTextureMediumWood = '\000f\000\030'
};
typedef enum PowerpointMPzT PowerpointMPzT;

enum PowerpointPpTy {
	PowerpointPpTyPatternUnset = '\000f\377\376',
	PowerpointPpTyFivePercentPattern = '\000g\000\001',
	PowerpointPpTyTenPercentPattern = '\000g\000\002',
	PowerpointPpTyTwentyPercentPattern = '\000g\000\003',
	PowerpointPpTyTwentyFivePercentPattern = '\000g\000\004',
	PowerpointPpTyThirtyPercentPattern = '\000g\000\005',
	PowerpointPpTyFortyPercentPattern = '\000g\000\006',
	PowerpointPpTyFiftyPercentPattern = '\000g\000\007',
	PowerpointPpTySixtyPercentPattern = '\000g\000\010',
	PowerpointPpTySeventyPercentPattern = '\000g\000\011',
	PowerpointPpTySeventyFivePercentPattern = '\000g\000\012',
	PowerpointPpTyEightyPercentPattern = '\000g\000\013',
	PowerpointPpTyNinetyPercentPattern = '\000g\000\014',
	PowerpointPpTyDarkHorizontalPattern = '\000g\000\015',
	PowerpointPpTyDarkVerticalPattern = '\000g\000\016',
	PowerpointPpTyDarkDownwardDiagonalPattern = '\000g\000\017',
	PowerpointPpTyDarkUpwardDiagonalPattern = '\000g\000\020',
	PowerpointPpTySmallCheckerBoardPattern = '\000g\000\021',
	PowerpointPpTyTrellisPattern = '\000g\000\022',
	PowerpointPpTyLightHorizontalPattern = '\000g\000\023',
	PowerpointPpTyLightVerticalPattern = '\000g\000\024',
	PowerpointPpTyLightDownwardDiagonalPattern = '\000g\000\025',
	PowerpointPpTyLightUpwardDiagonalPattern = '\000g\000\026',
	PowerpointPpTySmallGridPattern = '\000g\000\027',
	PowerpointPpTyDottedDiamondPattern = '\000g\000\030',
	PowerpointPpTyWideDownwardDiagonal = '\000g\000\031',
	PowerpointPpTyWideUpwardDiagonalPattern = '\000g\000\032',
	PowerpointPpTyDashedUpwardDiagonalPattern = '\000g\000\033',
	PowerpointPpTyDashedDownwardDiagonalPattern = '\000g\000\034',
	PowerpointPpTyNarrowVerticalPattern = '\000g\000\035',
	PowerpointPpTyNarrowHorizontalPattern = '\000g\000\036',
	PowerpointPpTyDashedVerticalPattern = '\000g\000\037',
	PowerpointPpTyDashedHorizontalPattern = '\000g\000 ',
	PowerpointPpTyLargeConfettiPattern = '\000g\000!',
	PowerpointPpTyLargeGridPattern = '\000g\000\"',
	PowerpointPpTyHorizontalBrickPattern = '\000g\000#',
	PowerpointPpTyLargeCheckerBoardPattern = '\000g\000$',
	PowerpointPpTySmallConfettiPattern = '\000g\000%',
	PowerpointPpTyZigZagPattern = '\000g\000&',
	PowerpointPpTySolidDiamondPattern = '\000g\000\'',
	PowerpointPpTyDiagonalBrickPattern = '\000g\000(',
	PowerpointPpTyOutlinedDiamondPattern = '\000g\000)',
	PowerpointPpTyPlaidPattern = '\000g\000*',
	PowerpointPpTySpherePattern = '\000g\000+',
	PowerpointPpTyWeavePattern = '\000g\000,',
	PowerpointPpTyDottedGridPattern = '\000g\000-',
	PowerpointPpTyDivotPattern = '\000g\000.',
	PowerpointPpTyShinglePattern = '\000g\000/',
	PowerpointPpTyWavePattern = '\000g\0000',
	PowerpointPpTyHorizontalPattern = '\000g\0001',
	PowerpointPpTyVerticalPattern = '\000g\0002',
	PowerpointPpTyCrossPattern = '\000g\0003',
	PowerpointPpTyDownwardDiagonalPattern = '\000g\0004',
	PowerpointPpTyUpwardDiagonalPattern = '\000g\0005',
	PowerpointPpTyDiagonalCrossPattern = '\000g\0005'
};
typedef enum PowerpointPpTy PowerpointPpTy;

enum PowerpointMPGb {
	PowerpointMPGbPresetGradientUnset = '\000g\377\376',
	PowerpointMPGbGradientEarlySunset = '\000h\000\001',
	PowerpointMPGbGradientLateSunset = '\000h\000\002',
	PowerpointMPGbGradientNightfall = '\000h\000\003',
	PowerpointMPGbGradientDaybreak = '\000h\000\004',
	PowerpointMPGbGradientHorizon = '\000h\000\005',
	PowerpointMPGbGradientDesert = '\000h\000\006',
	PowerpointMPGbGradientOcean = '\000h\000\007',
	PowerpointMPGbGradientCalmWater = '\000h\000\010',
	PowerpointMPGbGradientFire = '\000h\000\011',
	PowerpointMPGbGradientFog = '\000h\000\012',
	PowerpointMPGbGradientMoss = '\000h\000\013',
	PowerpointMPGbGradientPeacock = '\000h\000\014',
	PowerpointMPGbGradientWheat = '\000h\000\015',
	PowerpointMPGbGradientParchment = '\000h\000\016',
	PowerpointMPGbGradientMahogany = '\000h\000\017',
	PowerpointMPGbGradientRainbow = '\000h\000\020',
	PowerpointMPGbGradientRainbow2 = '\000h\000\021',
	PowerpointMPGbGradientGold = '\000h\000\022',
	PowerpointMPGbGradientGold2 = '\000h\000\023',
	PowerpointMPGbGradientBrass = '\000h\000\024',
	PowerpointMPGbGradientChrome = '\000h\000\025',
	PowerpointMPGbGradientChrome2 = '\000h\000\026',
	PowerpointMPGbGradientSilver = '\000h\000\027',
	PowerpointMPGbGradientSapphire = '\000h\000\030'
};
typedef enum PowerpointMPGb PowerpointMPGb;

enum PowerpointMSdT {
	PowerpointMSdTShadowUnset = '\003_\377\376',
	PowerpointMSdTShadow1 = '\003`\000\001',
	PowerpointMSdTShadow2 = '\003`\000\002',
	PowerpointMSdTShadow3 = '\003`\000\003',
	PowerpointMSdTShadow4 = '\003`\000\004',
	PowerpointMSdTShadow5 = '\003`\000\005',
	PowerpointMSdTShadow6 = '\003`\000\006',
	PowerpointMSdTShadow7 = '\003`\000\007',
	PowerpointMSdTShadow8 = '\003`\000\010',
	PowerpointMSdTShadow9 = '\003`\000\011',
	PowerpointMSdTShadow10 = '\003`\000\012',
	PowerpointMSdTShadow11 = '\003`\000\013',
	PowerpointMSdTShadow12 = '\003`\000\014',
	PowerpointMSdTShadow13 = '\003`\000\015',
	PowerpointMSdTShadow14 = '\003`\000\016',
	PowerpointMSdTShadow15 = '\003`\000\017',
	PowerpointMSdTShadow16 = '\003`\000\020',
	PowerpointMSdTShadow17 = '\003`\000\021',
	PowerpointMSdTShadow18 = '\003`\000\022',
	PowerpointMSdTShadow19 = '\003`\000\023',
	PowerpointMSdTShadow20 = '\003`\000\024'
};
typedef enum PowerpointMSdT PowerpointMSdT;

enum PowerpointMPXF {
	PowerpointMPXFWordartFormatUnset = '\003\361\377\376',
	PowerpointMPXFWordartFormat1 = '\003\362\000\000',
	PowerpointMPXFWordartFormat2 = '\003\362\000\001',
	PowerpointMPXFWordartFormat3 = '\003\362\000\002',
	PowerpointMPXFWordartFormat4 = '\003\362\000\003',
	PowerpointMPXFWordartFormat5 = '\003\362\000\004',
	PowerpointMPXFWordartFormat6 = '\003\362\000\005',
	PowerpointMPXFWordartFormat7 = '\003\362\000\006',
	PowerpointMPXFWordartFormat8 = '\003\362\000\007',
	PowerpointMPXFWordartFormat9 = '\003\362\000\010',
	PowerpointMPXFWordartFormat10 = '\003\362\000\011',
	PowerpointMPXFWordartFormat11 = '\003\362\000\012',
	PowerpointMPXFWordartFormat12 = '\003\362\000\013',
	PowerpointMPXFWordartFormat13 = '\003\362\000\014',
	PowerpointMPXFWordartFormat14 = '\003\362\000\015',
	PowerpointMPXFWordartFormat15 = '\003\362\000\016',
	PowerpointMPXFWordartFormat16 = '\003\362\000\017',
	PowerpointMPXFWordartFormat17 = '\003\362\000\020',
	PowerpointMPXFWordartFormat18 = '\003\362\000\021',
	PowerpointMPXFWordartFormat19 = '\003\362\000\022',
	PowerpointMPXFWordartFormat20 = '\003\362\000\023',
	PowerpointMPXFWordartFormat21 = '\003\362\000\024',
	PowerpointMPXFWordartFormat22 = '\003\362\000\025',
	PowerpointMPXFWordartFormat23 = '\003\362\000\026',
	PowerpointMPXFWordartFormat24 = '\003\362\000\027',
	PowerpointMPXFWordartFormat25 = '\003\362\000\030',
	PowerpointMPXFWordartFormat26 = '\003\362\000\031',
	PowerpointMPXFWordartFormat27 = '\003\362\000\032',
	PowerpointMPXFWordartFormat28 = '\003\362\000\033',
	PowerpointMPXFWordartFormat29 = '\003\362\000\034',
	PowerpointMPXFWordartFormat30 = '\003\362\000\035'
};
typedef enum PowerpointMPXF PowerpointMPXF;

enum PowerpointMPTs {
	PowerpointMPTsTextEffectShapeUnset = '\000\227\377\376',
	PowerpointMPTsPlainText = '\000\230\000\001',
	PowerpointMPTsStop = '\000\230\000\002',
	PowerpointMPTsTriangleUp = '\000\230\000\003',
	PowerpointMPTsTriangleDown = '\000\230\000\004',
	PowerpointMPTsChevronUp = '\000\230\000\005',
	PowerpointMPTsChevronDown = '\000\230\000\006',
	PowerpointMPTsRingInside = '\000\230\000\007',
	PowerpointMPTsRingOutside = '\000\230\000\010',
	PowerpointMPTsArchUpCurve = '\000\230\000\011',
	PowerpointMPTsArchDownCurve = '\000\230\000\012',
	PowerpointMPTsCircleCurve = '\000\230\000\013',
	PowerpointMPTsButtonCurve = '\000\230\000\014',
	PowerpointMPTsArchUpPour = '\000\230\000\015',
	PowerpointMPTsArchDownPour = '\000\230\000\016',
	PowerpointMPTsCirclePour = '\000\230\000\017',
	PowerpointMPTsButtonPour = '\000\230\000\020',
	PowerpointMPTsCurveUp = '\000\230\000\021',
	PowerpointMPTsCurveDown = '\000\230\000\022',
	PowerpointMPTsCanUp = '\000\230\000\023',
	PowerpointMPTsCanDown = '\000\230\000\024',
	PowerpointMPTsWave1 = '\000\230\000\025',
	PowerpointMPTsWave2 = '\000\230\000\026',
	PowerpointMPTsDoubleWave1 = '\000\230\000\027',
	PowerpointMPTsDoubleWave2 = '\000\230\000\030',
	PowerpointMPTsInflate = '\000\230\000\031',
	PowerpointMPTsDeflate = '\000\230\000\032',
	PowerpointMPTsInflateBottom = '\000\230\000\033',
	PowerpointMPTsDeflateBottom = '\000\230\000\034',
	PowerpointMPTsInflateTop = '\000\230\000\035',
	PowerpointMPTsDeflateTop = '\000\230\000\036',
	PowerpointMPTsDeflateInflate = '\000\230\000\037',
	PowerpointMPTsDeflateInflateDeflate = '\000\230\000 ',
	PowerpointMPTsFadeRight = '\000\230\000!',
	PowerpointMPTsFadeLeft = '\000\230\000\"',
	PowerpointMPTsFadeUp = '\000\230\000#',
	PowerpointMPTsFadeDown = '\000\230\000$',
	PowerpointMPTsSlantUp = '\000\230\000%',
	PowerpointMPTsSlantDown = '\000\230\000&',
	PowerpointMPTsCascadeUp = '\000\230\000\'',
	PowerpointMPTsCascadeDown = '\000\230\000('
};
typedef enum PowerpointMPTs PowerpointMPTs;

enum PowerpointMTxA {
	PowerpointMTxATextEffectAlignmentUnset = '\000\226\377\376',
	PowerpointMTxALeftTextEffectAlignment = '\000\227\000\001',
	PowerpointMTxACenteredTextEffectAlignment = '\000\227\000\002',
	PowerpointMTxARightTextEffectAlignment = '\000\227\000\003',
	PowerpointMTxAJustifyTextEffectAlignment = '\000\227\000\004',
	PowerpointMTxAWordJustifyTextEffectAlignment = '\000\227\000\005',
	PowerpointMTxAStretchJustifyTextEffectAlignment = '\000\227\000\006'
};
typedef enum PowerpointMTxA PowerpointMTxA;

enum PowerpointMPLd {
	PowerpointMPLdPresetLightingDirectionUnset = '\000\233\377\376',
	PowerpointMPLdLightFromTopLeft = '\000\234\000\001',
	PowerpointMPLdLightFromTop = '\000\234\000\002',
	PowerpointMPLdLightFromTopRight = '\000\234\000\003',
	PowerpointMPLdLightFromLeft = '\000\234\000\004',
	PowerpointMPLdLightFromNone = '\000\234\000\005',
	PowerpointMPLdLightFromRight = '\000\234\000\006',
	PowerpointMPLdLightFromBottomLeft = '\000\234\000\007',
	PowerpointMPLdLightFromBottom = '\000\234\000\010',
	PowerpointMPLdLightFromBottomRight = '\000\234\000\011'
};
typedef enum PowerpointMPLd PowerpointMPLd;

enum PowerpointMlSf {
	PowerpointMlSfLightingSoftnessUnset = '\000\234\377\376',
	PowerpointMlSfLightingDim = '\000\235\000\001',
	PowerpointMlSfLightingNormal = '\000\235\000\002',
	PowerpointMlSfLightingBright = '\000\235\000\003'
};
typedef enum PowerpointMlSf PowerpointMlSf;

enum PowerpointMPMt {
	PowerpointMPMtPresetMaterialUnset = '\000\235\377\376',
	PowerpointMPMtMatte = '\000\236\000\001',
	PowerpointMPMtPlastic = '\000\236\000\002',
	PowerpointMPMtMetal = '\000\236\000\003',
	PowerpointMPMtWireframe = '\000\236\000\004',
	PowerpointMPMtMatte2 = '\000\236\000\005',
	PowerpointMPMtPlastic2 = '\000\236\000\006',
	PowerpointMPMtMetal2 = '\000\236\000\007',
	PowerpointMPMtWarmMatte = '\000\236\000\010',
	PowerpointMPMtTranslucentPowder = '\000\236\000\011',
	PowerpointMPMtPowder = '\000\236\000\012',
	PowerpointMPMtDarkEdge = '\000\236\000\013',
	PowerpointMPMtSoftEdge = '\000\236\000\014',
	PowerpointMPMtMaterialClear = '\000\236\000\015',
	PowerpointMPMtFlat = '\000\236\000\016',
	PowerpointMPMtSoftMetal = '\000\236\000\017'
};
typedef enum PowerpointMPMt PowerpointMPMt;

enum PowerpointMExD {
	PowerpointMExDPresetExtrusionDirectionUnset = '\000\231\377\376',
	PowerpointMExDExtrudeBottomRight = '\000\232\000\001',
	PowerpointMExDExtrudeBottom = '\000\232\000\002',
	PowerpointMExDExtrudeBottomLeft = '\000\232\000\003',
	PowerpointMExDExtrudeRight = '\000\232\000\004',
	PowerpointMExDExtrudeNone = '\000\232\000\005',
	PowerpointMExDExtrudeLeft = '\000\232\000\006',
	PowerpointMExDExtrudeTopRight = '\000\232\000\007',
	PowerpointMExDExtrudeTop = '\000\232\000\010',
	PowerpointMExDExtrudeTopLeft = '\000\232\000\011'
};
typedef enum PowerpointMExD PowerpointMExD;

enum PowerpointM3DF {
	PowerpointM3DFPresetThreeDFormatUnset = '\000\230\377\376',
	PowerpointM3DFFormat1 = '\000\231\000\001',
	PowerpointM3DFFormat2 = '\000\231\000\002',
	PowerpointM3DFFormat3 = '\000\231\000\003',
	PowerpointM3DFFormat4 = '\000\231\000\004',
	PowerpointM3DFFormat5 = '\000\231\000\005',
	PowerpointM3DFFormat6 = '\000\231\000\006',
	PowerpointM3DFFormat7 = '\000\231\000\007',
	PowerpointM3DFFormat8 = '\000\231\000\010',
	PowerpointM3DFFormat9 = '\000\231\000\011',
	PowerpointM3DFFormat10 = '\000\231\000\012',
	PowerpointM3DFFormat11 = '\000\231\000\013',
	PowerpointM3DFFormat12 = '\000\231\000\014',
	PowerpointM3DFFormat13 = '\000\231\000\015',
	PowerpointM3DFFormat14 = '\000\231\000\016',
	PowerpointM3DFFormat15 = '\000\231\000\017',
	PowerpointM3DFFormat16 = '\000\231\000\020',
	PowerpointM3DFFormat17 = '\000\231\000\021',
	PowerpointM3DFFormat18 = '\000\231\000\022',
	PowerpointM3DFFormat19 = '\000\231\000\023',
	PowerpointM3DFFormat20 = '\000\231\000\024'
};
typedef enum PowerpointM3DF PowerpointM3DF;

enum PowerpointMExC {
	PowerpointMExCExtrusionColorUnset = '\000\232\377\376',
	PowerpointMExCExtrusionColorAutomatic = '\000\233\000\001',
	PowerpointMExCExtrusionColorCustom = '\000\233\000\002'
};
typedef enum PowerpointMExC PowerpointMExC;

enum PowerpointMCtT {
	PowerpointMCtTConnectorTypeUnset = '\000h\377\376',
	PowerpointMCtTStraight = '\000i\000\001',
	PowerpointMCtTElbow = '\000i\000\002',
	PowerpointMCtTCurve = '\000i\000\003'
};
typedef enum PowerpointMCtT PowerpointMCtT;

enum PowerpointMHzA {
	PowerpointMHzAHorizontalAnchorUnset = '\000\236\377\376',
	PowerpointMHzAHorizontalAnchorNone = '\000\237\000\001',
	PowerpointMHzAHorizontalAnchorCenter = '\000\237\000\002'
};
typedef enum PowerpointMHzA PowerpointMHzA;

enum PowerpointMVtA {
	PowerpointMVtAVerticalAnchorUnset = '\000\237\377\376',
	PowerpointMVtAAnchorTop = '\000\240\000\001',
	PowerpointMVtAAnchorTopBaseline = '\000\240\000\002',
	PowerpointMVtAAnchorMiddle = '\000\240\000\003',
	PowerpointMVtAAnchorBottom = '\000\240\000\004',
	PowerpointMVtAAnchorBottomBaseline = '\000\240\000\005'
};
typedef enum PowerpointMVtA PowerpointMVtA;

enum PowerpointMAsT {
	PowerpointMAsTAutoshapeShapeTypeUnset = '\000i\377\376',
	PowerpointMAsTAutoshapeRectangle = '\000j\000\001',
	PowerpointMAsTAutoshapeParallelogram = '\000j\000\002',
	PowerpointMAsTAutoshapeTrapezoid = '\000j\000\003',
	PowerpointMAsTAutoshapeDiamond = '\000j\000\004',
	PowerpointMAsTAutoshapeRoundedRectangle = '\000j\000\005',
	PowerpointMAsTAutoshapeOctagon = '\000j\000\006',
	PowerpointMAsTAutoshapeIsoscelesTriangle = '\000j\000\007',
	PowerpointMAsTAutoshapeRightTriangle = '\000j\000\010',
	PowerpointMAsTAutoshapeOval = '\000j\000\011',
	PowerpointMAsTAutoshapeHexagon = '\000j\000\012',
	PowerpointMAsTAutoshapeCross = '\000j\000\013',
	PowerpointMAsTAutoshapeRegularPentagon = '\000j\000\014',
	PowerpointMAsTAutoshapeCan = '\000j\000\015',
	PowerpointMAsTAutoshapeCube = '\000j\000\016',
	PowerpointMAsTAutoshapeBevel = '\000j\000\017',
	PowerpointMAsTAutoshapeFoldedCorner = '\000j\000\020',
	PowerpointMAsTAutoshapeSmileyFace = '\000j\000\021',
	PowerpointMAsTAutoshapeDonut = '\000j\000\022',
	PowerpointMAsTAutoshapeNoSymbol = '\000j\000\023',
	PowerpointMAsTAutoshapeBlockArc = '\000j\000\024',
	PowerpointMAsTAutoshapeHeart = '\000j\000\025',
	PowerpointMAsTAutoshapeLightningBolt = '\000j\000\026',
	PowerpointMAsTAutoshapeSun = '\000j\000\027',
	PowerpointMAsTAutoshapeMoon = '\000j\000\030',
	PowerpointMAsTAutoshapeArc = '\000j\000\031',
	PowerpointMAsTAutoshapeDoubleBracket = '\000j\000\032',
	PowerpointMAsTAutoshapeDoubleBrace = '\000j\000\033',
	PowerpointMAsTAutoshapePlaque = '\000j\000\034',
	PowerpointMAsTAutoshapeLeftBracket = '\000j\000\035',
	PowerpointMAsTAutoshapeRightBracket = '\000j\000\036',
	PowerpointMAsTAutoshapeLeftBrace = '\000j\000\037',
	PowerpointMAsTAutoshapeRightBrace = '\000j\000 ',
	PowerpointMAsTAutoshapeRightArrow = '\000j\000!',
	PowerpointMAsTAutoshapeLeftArrow = '\000j\000\"',
	PowerpointMAsTAutoshapeUpArrow = '\000j\000#',
	PowerpointMAsTAutoshapeDownArrow = '\000j\000$',
	PowerpointMAsTAutoshapeLeftRightArrow = '\000j\000%',
	PowerpointMAsTAutoshapeUpDownArrow = '\000j\000&',
	PowerpointMAsTAutoshapeQuadArrow = '\000j\000\'',
	PowerpointMAsTAutoshapeLeftRightUpArrow = '\000j\000(',
	PowerpointMAsTAutoshapeBentArrow = '\000j\000)',
	PowerpointMAsTAutoshapeUTurnArrow = '\000j\000*',
	PowerpointMAsTAutoshapeLeftUpArrow = '\000j\000+',
	PowerpointMAsTAutoshapeBentUpArrow = '\000j\000,',
	PowerpointMAsTAutoshapeCurvedRightArrow = '\000j\000-',
	PowerpointMAsTAutoshapeCurvedLeftArrow = '\000j\000.',
	PowerpointMAsTAutoshapeCurvedUpArrow = '\000j\000/',
	PowerpointMAsTAutoshapeCurvedDownArrow = '\000j\0000',
	PowerpointMAsTAutoshapeStripedRightArrow = '\000j\0001',
	PowerpointMAsTAutoshapeNotchedRightArrow = '\000j\0002',
	PowerpointMAsTAutoshapePentagon = '\000j\0003',
	PowerpointMAsTAutoshapeChevron = '\000j\0004',
	PowerpointMAsTAutoshapeRightArrowCallout = '\000j\0005',
	PowerpointMAsTAutoshapeLeftArrowCallout = '\000j\0006',
	PowerpointMAsTAutoshapeUpArrowCallout = '\000j\0007',
	PowerpointMAsTAutoshapeDownArrowCallout = '\000j\0008',
	PowerpointMAsTAutoshapeLeftRightArrowCallout = '\000j\0009',
	PowerpointMAsTAutoshapeUpDownArrowCallout = '\000j\000:',
	PowerpointMAsTAutoshapeQuadArrowCallout = '\000j\000;',
	PowerpointMAsTAutoshapeCircularArrow = '\000j\000<',
	PowerpointMAsTAutoshapeFlowchartProcess = '\000j\000=',
	PowerpointMAsTAutoshapeFlowchartAlternateProcess = '\000j\000>',
	PowerpointMAsTAutoshapeFlowchartDecision = '\000j\000\?',
	PowerpointMAsTAutoshapeFlowchartData = '\000j\000@',
	PowerpointMAsTAutoshapeFlowchartPredefinedProcess = '\000j\000A',
	PowerpointMAsTAutoshapeFlowchartInternalStorage = '\000j\000B',
	PowerpointMAsTAutoshapeFlowchartDocument = '\000j\000C',
	PowerpointMAsTAutoshapeFlowchartMultiDocument = '\000j\000D',
	PowerpointMAsTAutoshapeFlowchartTerminator = '\000j\000E',
	PowerpointMAsTAutoshapeFlowchartPreparation = '\000j\000F',
	PowerpointMAsTAutoshapeFlowchartManualInput = '\000j\000G',
	PowerpointMAsTAutoshapeFlowchartManualOperation = '\000j\000H',
	PowerpointMAsTAutoshapeFlowchartConnector = '\000j\000I',
	PowerpointMAsTAutoshapeFlowchartOffpageConnector = '\000j\000J',
	PowerpointMAsTAutoshapeFlowchartCard = '\000j\000K',
	PowerpointMAsTAutoshapeFlowchartPunchedTape = '\000j\000L',
	PowerpointMAsTAutoshapeFlowchartSummingJunction = '\000j\000M',
	PowerpointMAsTAutoshapeFlowchartOr = '\000j\000N',
	PowerpointMAsTAutoshapeFlowchartCollate = '\000j\000O',
	PowerpointMAsTAutoshapeFlowchartSort = '\000j\000P',
	PowerpointMAsTAutoshapeFlowchartExtract = '\000j\000Q',
	PowerpointMAsTAutoshapeFlowchartMerge = '\000j\000R',
	PowerpointMAsTAutoshapeFlowchartStoredData = '\000j\000S',
	PowerpointMAsTAutoshapeFlowchartDelay = '\000j\000T',
	PowerpointMAsTAutoshapeFlowchartSequentialAccessStorage = '\000j\000U',
	PowerpointMAsTAutoshapeFlowchartMagneticDisk = '\000j\000V',
	PowerpointMAsTAutoshapeFlowchartDirectAccessStorage = '\000j\000W',
	PowerpointMAsTAutoshapeFlowchartDisplay = '\000j\000X',
	PowerpointMAsTAutoshapeExplosionOne = '\000j\000Y',
	PowerpointMAsTAutoshapeExplosionTwo = '\000j\000Z',
	PowerpointMAsTAutoshapeFourPointStar = '\000j\000[',
	PowerpointMAsTAutoshapeFivePointStar = '\000j\000\\',
	PowerpointMAsTAutoshapeEightPointStar = '\000j\000]',
	PowerpointMAsTAutoshapeSixteenPointStar = '\000j\000^',
	PowerpointMAsTAutoshapeTwentyFourPointStar = '\000j\000_',
	PowerpointMAsTAutoshapeThirtyTwoPointStar = '\000j\000`',
	PowerpointMAsTAutoshapeUpRibbon = '\000j\000a',
	PowerpointMAsTAutoshapeDownRibbon = '\000j\000b',
	PowerpointMAsTAutoshapeCurvedUpRibbon = '\000j\000c',
	PowerpointMAsTAutoshapeCurvedDownRibbon = '\000j\000d',
	PowerpointMAsTAutoshapeVerticalScroll = '\000j\000e',
	PowerpointMAsTAutoshapeHorizontalScroll = '\000j\000f',
	PowerpointMAsTAutoshapeWave = '\000j\000g',
	PowerpointMAsTAutoshapeDoubleWave = '\000j\000h',
	PowerpointMAsTAutoshapeRectangularCallout = '\000j\000i',
	PowerpointMAsTAutoshapeRoundedRectangularCallout = '\000j\000j',
	PowerpointMAsTAutoshapeOvalCallout = '\000j\000k',
	PowerpointMAsTAutoshapeCloudCallout = '\000j\000l',
	PowerpointMAsTAutoshapeLineCalloutOne = '\000j\000m',
	PowerpointMAsTAutoshapeLineCalloutTwo = '\000j\000n',
	PowerpointMAsTAutoshapeLineCalloutThree = '\000j\000o',
	PowerpointMAsTAutoshapeLineCalloutFour = '\000j\000p',
	PowerpointMAsTAutoshapeLineCalloutOneAccentBar = '\000j\000q',
	PowerpointMAsTAutoshapeLineCalloutTwoAccentBar = '\000j\000r',
	PowerpointMAsTAutoshapeLineCalloutThreeAccentBar = '\000j\000s',
	PowerpointMAsTAutoshapeLineCalloutFourAccentBar = '\000j\000t',
	PowerpointMAsTAutoshapeLineCalloutOneNoBorder = '\000j\000u',
	PowerpointMAsTAutoshapeLineCalloutTwoNoBorder = '\000j\000v',
	PowerpointMAsTAutoshapeLineCalloutThreeNoBorder = '\000j\000w',
	PowerpointMAsTAutoshapeLineCalloutFourNoBorder = '\000j\000x',
	PowerpointMAsTAutoshapeCalloutOneBorderAndAccentBar = '\000j\000y',
	PowerpointMAsTAutoshapeCalloutTwoBorderAndAccentBar = '\000j\000z',
	PowerpointMAsTAutoshapeCalloutThreeBorderAndAccentBar = '\000j\000{',
	PowerpointMAsTAutoshapeCalloutFourBorderAndAccentBar = '\000j\000|',
	PowerpointMAsTAutoshapeActionButtonCustom = '\000j\000}',
	PowerpointMAsTAutoshapeActionButtonHome = '\000j\000~',
	PowerpointMAsTAutoshapeActionButtonHelp = '\000j\000\177',
	PowerpointMAsTAutoshapeActionButtonInformation = '\000j\000\200',
	PowerpointMAsTAutoshapeActionButtonBackOrPrevious = '\000j\000\201',
	PowerpointMAsTAutoshapeActionButtonForwardOrNext = '\000j\000\202',
	PowerpointMAsTAutoshapeActionButtonBeginning = '\000j\000\203',
	PowerpointMAsTAutoshapeActionButtonEnd = '\000j\000\204',
	PowerpointMAsTAutoshapeActionButtonReturn = '\000j\000\205',
	PowerpointMAsTAutoshapeActionButtonDocument = '\000j\000\206',
	PowerpointMAsTAutoshapeActionButtonSound = '\000j\000\207',
	PowerpointMAsTAutoshapeActionButtonMovie = '\000j\000\210',
	PowerpointMAsTAutoshapeBalloon = '\000j\000\211',
	PowerpointMAsTAutoshapeNotPrimitive = '\000j\000\212',
	PowerpointMAsTAutoshapeFlowchartOfflineStorage = '\000j\000\213',
	PowerpointMAsTAutoshapeLeftRightRibbon = '\000j\000\214',
	PowerpointMAsTAutoshapeDiagonalStripe = '\000j\000\215',
	PowerpointMAsTAutoshapePie = '\000j\000\216',
	PowerpointMAsTAutoshapeNonIsoscelesTrapezoid = '\000j\000\217',
	PowerpointMAsTAutoshapeDecagon = '\000j\000\220',
	PowerpointMAsTAutoshapeHeptagon = '\000j\000\221',
	PowerpointMAsTAutoshapeDodecagon = '\000j\000\222',
	PowerpointMAsTAutoshapeSixPointsStar = '\000j\000\223',
	PowerpointMAsTAutoshapeSevenPointsStar = '\000j\000\224',
	PowerpointMAsTAutoshapeTenPointsStar = '\000j\000\225',
	PowerpointMAsTAutoshapeTwelvePointsStar = '\000j\000\226',
	PowerpointMAsTAutoshapeRoundOneRectangle = '\000j\000\227',
	PowerpointMAsTAutoshapeRoundTwoSameRectangle = '\000j\000\230',
	PowerpointMAsTAutoshapeRoundTwoDiagonalRectangle = '\000j\000\231',
	PowerpointMAsTAutoshapeSnipRoundRectangle = '\000j\000\232',
	PowerpointMAsTAutoshapeSnipOneRectangle = '\000j\000\233',
	PowerpointMAsTAutoshapeSnipTwoSameRectangle = '\000j\000\234',
	PowerpointMAsTAutoshapeSnipTwoDiagonalRectangle = '\000j\000\235',
	PowerpointMAsTAutoshapeFrame = '\000j\000\236',
	PowerpointMAsTAutoshapeHalfFrame = '\000j\000\237',
	PowerpointMAsTAutoshapeTear = '\000j\000\240',
	PowerpointMAsTAutoshapeChord = '\000j\000\241',
	PowerpointMAsTAutoshapeCorner = '\000j\000\242',
	PowerpointMAsTAutoshapeMathPlus = '\000j\000\243',
	PowerpointMAsTAutoshapeMathMinus = '\000j\000\244',
	PowerpointMAsTAutoshapeMathMultiply = '\000j\000\245',
	PowerpointMAsTAutoshapeMathDivide = '\000j\000\246',
	PowerpointMAsTAutoshapeMathEqual = '\000j\000\247',
	PowerpointMAsTAutoshapeMathNotEqual = '\000j\000\250',
	PowerpointMAsTAutoshapeCornerTabs = '\000j\000\251',
	PowerpointMAsTAutoshapeSquareTabs = '\000j\000\252',
	PowerpointMAsTAutoshapePlaqueTabs = '\000j\000\253',
	PowerpointMAsTAutoshapeGearSix = '\000j\000\254',
	PowerpointMAsTAutoshapeGearNine = '\000j\000\255',
	PowerpointMAsTAutoshapeFunnel = '\000j\000\256',
	PowerpointMAsTAutoshapePieWedge = '\000j\000\257',
	PowerpointMAsTAutoshapeLeftCircularArrow = '\000j\000\260',
	PowerpointMAsTAutoshapeLeftRightCircularArrow = '\000j\000\261',
	PowerpointMAsTAutoshapeSwooshArrow = '\000j\000\262',
	PowerpointMAsTAutoshapeCloud = '\000j\000\263',
	PowerpointMAsTAutoshapeChartX = '\000j\000\264',
	PowerpointMAsTAutoshapeChartStar = '\000j\000\265',
	PowerpointMAsTAutoshapeChartPlus = '\000j\000\266',
	PowerpointMAsTAutoshapeLineInverse = '\000j\000\267'
};
typedef enum PowerpointMAsT PowerpointMAsT;

enum PowerpointMShp {
	PowerpointMShpShapeTypeUnset = '\000\213\377\376',
	PowerpointMShpShapeTypeAuto = '\000\214\000\001',
	PowerpointMShpShapeTypeCallout = '\000\214\000\002',
	PowerpointMShpShapeTypeChart = '\000\214\000\003',
	PowerpointMShpShapeTypeComment = '\000\214\000\004',
	PowerpointMShpShapeTypeFreeForm = '\000\214\000\005',
	PowerpointMShpShapeTypeGroup = '\000\214\000\006',
	PowerpointMShpShapeTypeEmbeddedOLEControl = '\000\214\000\007',
	PowerpointMShpShapeTypeFormControl = '\000\214\000\010',
	PowerpointMShpShapeTypeLine = '\000\214\000\011',
	PowerpointMShpShapeTypeLinkedOLEObject = '\000\214\000\012',
	PowerpointMShpShapeTypeLinkedPicture = '\000\214\000\013',
	PowerpointMShpShapeTypeOLEControl = '\000\214\000\014',
	PowerpointMShpShapeTypePicture = '\000\214\000\015',
	PowerpointMShpShapeTypePlaceHolder = '\000\214\000\016',
	PowerpointMShpShapeTypeWordArt = '\000\214\000\017',
	PowerpointMShpShapeTypeMedia = '\000\214\000\020',
	PowerpointMShpShapeTypeTextBox = '\000\214\000\021',
	PowerpointMShpShapeTypeTable = '\000\214\000\022',
	PowerpointMShpShapeTypeSmartartGraphic = '\000\214\000\023'
};
typedef enum PowerpointMShp PowerpointMShp;

enum PowerpointMCrT {
	PowerpointMCrTColorTypeUnset = '\000j\377\376',
	PowerpointMCrTRGB = '\000k\000\001',
	PowerpointMCrTScheme = '\000k\000\002'
};
typedef enum PowerpointMCrT PowerpointMCrT;

enum PowerpointMPc {
	PowerpointMPcPictureColorTypeUnset = '\000\265\377\376',
	PowerpointMPcPictureColorAutomatic = '\000\266\000\001',
	PowerpointMPcPictureColorGrayScale = '\000\266\000\002',
	PowerpointMPcPictureColorBlackAndWhite = '\000\266\000\003',
	PowerpointMPcPictureColorWatermark = '\000\266\000\004'
};
typedef enum PowerpointMPc PowerpointMPc;

enum PowerpointMCAt {
	PowerpointMCAtAngleUnset = '\000k\377\376',
	PowerpointMCAtAngleAutomatic = '\000l\000\001',
	PowerpointMCAtAngle30 = '\000l\000\002',
	PowerpointMCAtAngle45 = '\000l\000\003',
	PowerpointMCAtAngle60 = '\000l\000\004',
	PowerpointMCAtAngle90 = '\000l\000\005'
};
typedef enum PowerpointMCAt PowerpointMCAt;

enum PowerpointMCDt {
	PowerpointMCDtDropUnset = '\000l\377\376',
	PowerpointMCDtDropCustom = '\000m\000\001',
	PowerpointMCDtDropTop = '\000m\000\002',
	PowerpointMCDtDropCenter = '\000m\000\003',
	PowerpointMCDtDropBottom = '\000m\000\004'
};
typedef enum PowerpointMCDt PowerpointMCDt;

enum PowerpointMCot {
	PowerpointMCotCalloutUnset = '\000m\377\376',
	PowerpointMCotCalloutOne = '\000n\000\001',
	PowerpointMCotCalloutTwo = '\000n\000\002',
	PowerpointMCotCalloutThree = '\000n\000\003',
	PowerpointMCotCalloutFour = '\000n\000\004'
};
typedef enum PowerpointMCot PowerpointMCot;

enum PowerpointTxOr {
	PowerpointTxOrTextOrientationUnset = '\000\215\377\376',
	PowerpointTxOrHorizontal = '\000\216\000\001',
	PowerpointTxOrUpward = '\000\216\000\002',
	PowerpointTxOrDownward = '\000\216\000\003',
	PowerpointTxOrVerticalEastAsian = '\000\216\000\004',
	PowerpointTxOrVertical = '\000\216\000\005',
	PowerpointTxOrHorizontalRotatedEastAsian = '\000\216\000\006'
};
typedef enum PowerpointTxOr PowerpointTxOr;

enum PowerpointMSFr {
	PowerpointMSFrScaleFromTopLeft = '\000o\000\000',
	PowerpointMSFrScaleFromMiddle = '\000o\000\001',
	PowerpointMSFrScaleFromBottomRight = '\000o\000\002'
};
typedef enum PowerpointMSFr PowerpointMSFr;

enum PowerpointMPzC {
	PowerpointMPzCPresetCameraUnset = '\000\256\377\376',
	PowerpointMPzCCameraLegacyObliqueFromTopLeft = '\000\257\000\001',
	PowerpointMPzCCameraLegacyObliqueFromTop = '\000\257\000\002',
	PowerpointMPzCCameraLegacyObliqueFromTopright = '\000\257\000\003',
	PowerpointMPzCCameraLegacyObliqueFromLeft = '\000\257\000\004',
	PowerpointMPzCCameraLegacyObliqueFromFront = '\000\257\000\005',
	PowerpointMPzCCameraLegacyObliqueFromRight = '\000\257\000\006',
	PowerpointMPzCCameraLegacyObliqueFromBottomLeft = '\000\257\000\007',
	PowerpointMPzCCameraLegacyObliqueFromBottom = '\000\257\000\010',
	PowerpointMPzCCameraLegacyObliqueFromBottomRight = '\000\257\000\011',
	PowerpointMPzCCameraLegacyPerspectiveFromTopLeft = '\000\257\000\012',
	PowerpointMPzCCameraLegacyPerspectiveFromTop = '\000\257\000\013',
	PowerpointMPzCCameraLegacyPerspectiveFromTopRight = '\000\257\000\014',
	PowerpointMPzCCameraLegacyPerspectiveFromLeft = '\000\257\000\015',
	PowerpointMPzCCameraLegacyPerspectiveFromFront = '\000\257\000\016',
	PowerpointMPzCCameraLegacyPerspectiveFromRight = '\000\257\000\017',
	PowerpointMPzCCameraLegacyPerspectiveFromBottomLeft = '\000\257\000\020',
	PowerpointMPzCCameraLegacyPerspectiveFromBottom = '\000\257\000\021',
	PowerpointMPzCCameraLegacyPerspectiveFromBottomRight = '\000\257\000\022',
	PowerpointMPzCCameraOrthographic = '\000\257\000\023',
	PowerpointMPzCCameraIsometricFromTopUp = '\000\257\000\024',
	PowerpointMPzCCameraIsometricFromTopDown = '\000\257\000\025',
	PowerpointMPzCCameraIsometricFromBottomUp = '\000\257\000\026',
	PowerpointMPzCCameraIsometricFromBottomDown = '\000\257\000\027',
	PowerpointMPzCCameraIsometricFromLeftUp = '\000\257\000\030',
	PowerpointMPzCCameraIsometricFromLeftDown = '\000\257\000\031',
	PowerpointMPzCCameraIsometricFromRightUp = '\000\257\000\032',
	PowerpointMPzCCameraIsometricFromRightDown = '\000\257\000\033',
	PowerpointMPzCCameraIsometricOffAxis1FromLeft = '\000\257\000\034',
	PowerpointMPzCCameraIsometricOffAxis1FromRight = '\000\257\000\035',
	PowerpointMPzCCameraIsometricOffAxis1FromTop = '\000\257\000\036',
	PowerpointMPzCCameraIsometricOffAxis2FromLeft = '\000\257\000\037',
	PowerpointMPzCCameraIsometricOffAxis2FromRight = '\000\257\000 ',
	PowerpointMPzCCameraIsometricOffAxis2FromTop = '\000\257\000!',
	PowerpointMPzCCameraIsometricOffAxis3FromLeft = '\000\257\000\"',
	PowerpointMPzCCameraIsometricOffAxis3FromRight = '\000\257\000#',
	PowerpointMPzCCameraIsometricOffAxis3FromBottom = '\000\257\000$',
	PowerpointMPzCCameraIsometricOffAxis4FromLeft = '\000\257\000%',
	PowerpointMPzCCameraIsometricOffAxis4FromRight = '\000\257\000&',
	PowerpointMPzCCameraIsometricOffAxis4FromBottom = '\000\257\000\'',
	PowerpointMPzCCameraObliqueFromTopLeft = '\000\257\000(',
	PowerpointMPzCCameraObliqueFromTop = '\000\257\000)',
	PowerpointMPzCCameraObliqueFromTopRight = '\000\257\000*',
	PowerpointMPzCCameraObliqueFromLeft = '\000\257\000+',
	PowerpointMPzCCameraObliqueFromRight = '\000\257\000,',
	PowerpointMPzCCameraObliqueFromBottomLeft = '\000\257\000-',
	PowerpointMPzCCameraObliqueFromBottom = '\000\257\000.',
	PowerpointMPzCCameraObliqueFromBottomRight = '\000\257\000/',
	PowerpointMPzCCameraPerspectiveFromFront = '\000\257\0000',
	PowerpointMPzCCameraPerspectiveFromLeft = '\000\257\0001',
	PowerpointMPzCCameraPerspectiveFromRight = '\000\257\0002',
	PowerpointMPzCCameraPerspectiveFromAbove = '\000\257\0003',
	PowerpointMPzCCameraPerspectiveFromBelow = '\000\257\0004',
	PowerpointMPzCCameraPerspectiveFromAboveFacingLeft = '\000\257\0005',
	PowerpointMPzCCameraPerspectiveFromAboveFacingRight = '\000\257\0006',
	PowerpointMPzCCameraPerspectiveContrastingFacingLeft = '\000\257\0007',
	PowerpointMPzCCameraPerspectiveContrastingFacingRight = '\000\257\0008',
	PowerpointMPzCCameraPerspectiveHeroicFacingLeft = '\000\257\0009',
	PowerpointMPzCCameraPerspectiveHeroicFacingRight = '\000\257\000:',
	PowerpointMPzCCameraPerspectiveHeroicExtremeFacingLeft = '\000\257\000;',
	PowerpointMPzCCameraPerspectiveHeroicExtremeFacingRight = '\000\257\000<',
	PowerpointMPzCCameraPerspectiveRelaxed = '\000\257\000=',
	PowerpointMPzCCameraPerspectiveRelaxedModerately = '\000\257\000>'
};
typedef enum PowerpointMPzC PowerpointMPzC;

enum PowerpointMLtT {
	PowerpointMLtTLightRigUnset = '\000\257\377\376',
	PowerpointMLtTLightRigFlat1 = '\000\260\000\001',
	PowerpointMLtTLightRigFlat2 = '\000\260\000\002',
	PowerpointMLtTLightRigFlat3 = '\000\260\000\003',
	PowerpointMLtTLightRigFlat4 = '\000\260\000\004',
	PowerpointMLtTLightRigNormal1 = '\000\260\000\005',
	PowerpointMLtTLightRigNormal2 = '\000\260\000\006',
	PowerpointMLtTLightRigNormal3 = '\000\260\000\007',
	PowerpointMLtTLightRigNormal4 = '\000\260\000\010',
	PowerpointMLtTLightRigHarsh1 = '\000\260\000\011',
	PowerpointMLtTLightRigHarsh2 = '\000\260\000\012',
	PowerpointMLtTLightRigHarsh3 = '\000\260\000\013',
	PowerpointMLtTLightRigHarsh4 = '\000\260\000\014',
	PowerpointMLtTLightRigThreePoint = '\000\260\000\015',
	PowerpointMLtTLightRigBalanced = '\000\260\000\016',
	PowerpointMLtTLightRigSoft = '\000\260\000\017',
	PowerpointMLtTLightRigHarsh = '\000\260\000\020',
	PowerpointMLtTLightRigFlood = '\000\260\000\021',
	PowerpointMLtTLightRigContrasting = '\000\260\000\022',
	PowerpointMLtTLightRigMorning = '\000\260\000\023',
	PowerpointMLtTLightRigSunrise = '\000\260\000\024',
	PowerpointMLtTLightRigSunset = '\000\260\000\025',
	PowerpointMLtTLightRigChilly = '\000\260\000\026',
	PowerpointMLtTLightRigFreezing = '\000\260\000\027',
	PowerpointMLtTLightRigFlat = '\000\260\000\030',
	PowerpointMLtTLightRigTwoPoint = '\000\260\000\031',
	PowerpointMLtTLightRigGlow = '\000\260\000\032',
	PowerpointMLtTLightRigBrightRoom = '\000\260\000\033'
};
typedef enum PowerpointMLtT PowerpointMLtT;

enum PowerpointMBlT {
	PowerpointMBlTBevelTypeUnset = '\000\260\377\376',
	PowerpointMBlTBevelNone = '\000\261\000\001',
	PowerpointMBlTBevelRelaxedInset = '\000\261\000\002',
	PowerpointMBlTBevelCircle = '\000\261\000\003',
	PowerpointMBlTBevelSlope = '\000\261\000\004',
	PowerpointMBlTBevelCross = '\000\261\000\005',
	PowerpointMBlTBevelAngle = '\000\261\000\006',
	PowerpointMBlTBevelSoftRound = '\000\261\000\007',
	PowerpointMBlTBevelConvex = '\000\261\000\010',
	PowerpointMBlTBevelCoolSlant = '\000\261\000\011',
	PowerpointMBlTBevelDivot = '\000\261\000\012',
	PowerpointMBlTBevelRiblet = '\000\261\000\013',
	PowerpointMBlTBevelHardEdge = '\000\261\000\014',
	PowerpointMBlTBevelArtDeco = '\000\261\000\015'
};
typedef enum PowerpointMBlT PowerpointMBlT;

enum PowerpointMSSt {
	PowerpointMSStShadowStyleUnset = '\000\261\377\376',
	PowerpointMSStShadowStyleInner = '\000\262\000\001',
	PowerpointMSStShadowStyleOuter = '\000\262\000\002'
};
typedef enum PowerpointMSSt PowerpointMSSt;

enum PowerpointPpgA {
	PowerpointPpgAParagraphAlignmentUnset = '\000\346\377\376',
	PowerpointPpgAParagraphAlignLeft = '\000\347\000\000',
	PowerpointPpgAParagraphAlignCenter = '\000\347\000\001',
	PowerpointPpgAParagraphAlignRight = '\000\347\000\002',
	PowerpointPpgAParagraphAlignJustify = '\000\347\000\003',
	PowerpointPpgAParagraphAlignDistribute = '\000\347\000\004',
	PowerpointPpgAParagraphAlignThai = '\000\347\000\005',
	PowerpointPpgAParagraphAlignJustifyLow = '\000\347\000\006'
};
typedef enum PowerpointPpgA PowerpointPpgA;

enum PowerpointMTSt {
	PowerpointMTStStrikeUnset = '\000\263\377\376',
	PowerpointMTStNoStrike = '\000\264\000\000',
	PowerpointMTStSingleStrike = '\000\264\000\001',
	PowerpointMTStDoubleStrike = '\000\264\000\002'
};
typedef enum PowerpointMTSt PowerpointMTSt;

enum PowerpointMTCa {
	PowerpointMTCaCapsUnset = '\000\264\377\376',
	PowerpointMTCaNoCaps = '\000\265\000\000',
	PowerpointMTCaSmallCaps = '\000\265\000\001',
	PowerpointMTCaAllCaps = '\000\265\000\002'
};
typedef enum PowerpointMTCa PowerpointMTCa;

enum PowerpointMTUl {
	PowerpointMTUlUnderlineUnset = '\003\356\377\376',
	PowerpointMTUlNoUnderline = '\003\357\000\000',
	PowerpointMTUlUnderlineWordsOnly = '\003\357\000\001',
	PowerpointMTUlUnderlineSingleLine = '\003\357\000\002',
	PowerpointMTUlUnderlineDoubleLine = '\003\357\000\003',
	PowerpointMTUlUnderlineHeavyLine = '\003\357\000\004',
	PowerpointMTUlUnderlineDottedLine = '\003\357\000\005',
	PowerpointMTUlUnderlineHeavyDottedLine = '\003\357\000\006',
	PowerpointMTUlUnderlineDashLine = '\003\357\000\007',
	PowerpointMTUlUnderlineHeavyDashLine = '\003\357\000\010',
	PowerpointMTUlUnderlineLongDashLine = '\003\357\000\011',
	PowerpointMTUlUnderlineHeavyLongDashLine = '\003\357\000\012',
	PowerpointMTUlUnderlineDotDashLine = '\003\357\000\013',
	PowerpointMTUlUnderlineHeavyDotDashLine = '\003\357\000\014',
	PowerpointMTUlUnderlineDotDotDashLine = '\003\357\000\015',
	PowerpointMTUlUnderlineHeavyDotDotDashLine = '\003\357\000\016',
	PowerpointMTUlUnderlineWavyLine = '\003\357\000\017',
	PowerpointMTUlUnderlineHeavyWavyLine = '\003\357\000\020',
	PowerpointMTUlUnderlineWavyDoubleLine = '\003\357\000\021'
};
typedef enum PowerpointMTUl PowerpointMTUl;

enum PowerpointMTTA {
	PowerpointMTTATabUnset = '\000\266\377\376',
	PowerpointMTTALeftTab = '\000\267\000\000',
	PowerpointMTTACenterTab = '\000\267\000\001',
	PowerpointMTTARightTab = '\000\267\000\002',
	PowerpointMTTADecimalTab = '\000\267\000\003'
};
typedef enum PowerpointMTTA PowerpointMTTA;

enum PowerpointMTCW {
	PowerpointMTCWCharacterWrapUnset = '\000\267\377\376',
	PowerpointMTCWNoCharacterWrap = '\000\270\000\000',
	PowerpointMTCWStandardCharacterWrap = '\000\270\000\001',
	PowerpointMTCWStrictCharacterWrap = '\000\270\000\002',
	PowerpointMTCWCustomCharacterWrap = '\000\270\000\003'
};
typedef enum PowerpointMTCW PowerpointMTCW;

enum PowerpointMTFA {
	PowerpointMTFAFontAlignmentUnset = '\000\270\377\376',
	PowerpointMTFAAutomaticAlignment = '\000\271\000\000',
	PowerpointMTFATopAlignment = '\000\271\000\001',
	PowerpointMTFACenterAlignment = '\000\271\000\002',
	PowerpointMTFABaselineAlignment = '\000\271\000\003',
	PowerpointMTFABottomAlignment = '\000\271\000\004'
};
typedef enum PowerpointMTFA PowerpointMTFA;

enum PowerpointPAtS {
	PowerpointPAtSAutoSizeUnset = '\000\344\377\376',
	PowerpointPAtSAutoSizeNone = '\000\345\000\000',
	PowerpointPAtSShapeToFitText = '\000\345\000\001',
	PowerpointPAtSTextToFitShape = '\000\345\000\002'
};
typedef enum PowerpointPAtS PowerpointPAtS;

enum PowerpointMPFo {
	PowerpointMPFoPathTypeUnset = '\000\272\377\376',
	PowerpointMPFoNoPathType = '\000\273\000\000',
	PowerpointMPFoPathType1 = '\000\273\000\001',
	PowerpointMPFoPathType2 = '\000\273\000\002',
	PowerpointMPFoPathType3 = '\000\273\000\003',
	PowerpointMPFoPathType4 = '\000\273\000\004'
};
typedef enum PowerpointMPFo PowerpointMPFo;

enum PowerpointMWFo {
	PowerpointMWFoWarpFormatUnset = '\000\273\377\376',
	PowerpointMWFoWarpFormat1 = '\000\274\000\000',
	PowerpointMWFoWarpFormat2 = '\000\274\000\001',
	PowerpointMWFoWarpFormat3 = '\000\274\000\002',
	PowerpointMWFoWarpFormat4 = '\000\274\000\003',
	PowerpointMWFoWarpFormat5 = '\000\274\000\004',
	PowerpointMWFoWarpFormat6 = '\000\274\000\005',
	PowerpointMWFoWarpFormat7 = '\000\274\000\006',
	PowerpointMWFoWarpFormat8 = '\000\274\000\007',
	PowerpointMWFoWarpFormat9 = '\000\274\000\010',
	PowerpointMWFoWarpFormat10 = '\000\274\000\011',
	PowerpointMWFoWarpFormat11 = '\000\274\000\012',
	PowerpointMWFoWarpFormat12 = '\000\274\000\013',
	PowerpointMWFoWarpFormat13 = '\000\274\000\014',
	PowerpointMWFoWarpFormat14 = '\000\274\000\015',
	PowerpointMWFoWarpFormat15 = '\000\274\000\016',
	PowerpointMWFoWarpFormat16 = '\000\274\000\017',
	PowerpointMWFoWarpFormat17 = '\000\274\000\020',
	PowerpointMWFoWarpFormat18 = '\000\274\000\021',
	PowerpointMWFoWarpFormat19 = '\000\274\000\022',
	PowerpointMWFoWarpFormat20 = '\000\274\000\023',
	PowerpointMWFoWarpFormat21 = '\000\274\000\024',
	PowerpointMWFoWarpFormat22 = '\000\274\000\025',
	PowerpointMWFoWarpFormat23 = '\000\274\000\026',
	PowerpointMWFoWarpFormat24 = '\000\274\000\027',
	PowerpointMWFoWarpFormat25 = '\000\274\000\030',
	PowerpointMWFoWarpFormat26 = '\000\274\000\031',
	PowerpointMWFoWarpFormat27 = '\000\274\000\032',
	PowerpointMWFoWarpFormat28 = '\000\274\000\033',
	PowerpointMWFoWarpFormat29 = '\000\274\000\034',
	PowerpointMWFoWarpFormat30 = '\000\274\000\035',
	PowerpointMWFoWarpFormat31 = '\000\274\000\036',
	PowerpointMWFoWarpFormat32 = '\000\274\000\037',
	PowerpointMWFoWarpFormat33 = '\000\274\000 ',
	PowerpointMWFoWarpFormat34 = '\000\274\000!',
	PowerpointMWFoWarpFormat35 = '\000\274\000\"',
	PowerpointMWFoWarpFormat36 = '\000\274\000#'
};
typedef enum PowerpointMWFo PowerpointMWFo;

enum PowerpointPCgC {
	PowerpointPCgCCaseSentence = '\000\344\000\001',
	PowerpointPCgCCaseLower = '\000\344\000\002',
	PowerpointPCgCCaseUpper = '\000\344\000\003',
	PowerpointPCgCCaseTitle = '\000\344\000\004',
	PowerpointPCgCCaseToggle = '\000\344\000\005'
};
typedef enum PowerpointPCgC PowerpointPCgC;

enum PowerpointMDTF {
	PowerpointMDTFDateTimeFormatUnset = '\000\275\377\376',
	PowerpointMDTFDateTimeFormatMdyy = '\000\276\000\001',
	PowerpointMDTFDateTimeFormatDdddMMMMddyyyy = '\000\276\000\002',
	PowerpointMDTFDateTimeFormatDMMMMyyyy = '\000\276\000\003',
	PowerpointMDTFDateTimeFormatMMMMdyyyy = '\000\276\000\004',
	PowerpointMDTFDateTimeFormatDMMMyy = '\000\276\000\005',
	PowerpointMDTFDateTimeFormatMMMMyy = '\000\276\000\006',
	PowerpointMDTFDateTimeFormatMMyy = '\000\276\000\007',
	PowerpointMDTFDateTimeFormatMMddyyHmm = '\000\276\000\010',
	PowerpointMDTFDateTimeFormatMMddyyhmmAMPM = '\000\276\000\011',
	PowerpointMDTFDateTimeFormatHmm = '\000\276\000\012',
	PowerpointMDTFDateTimeFormatHmmss = '\000\276\000\013',
	PowerpointMDTFDateTimeFormatHmmAMPM = '\000\276\000\014',
	PowerpointMDTFDateTimeFormatHmmssAMPM = '\000\276\000\015',
	PowerpointMDTFDateTimeFormatFigureOut = '\000\276\000\016'
};
typedef enum PowerpointMDTF PowerpointMDTF;

enum PowerpointMSET {
	PowerpointMSETSoftEdgeUnset = '\000\277\377\376',
	PowerpointMSETNoSoftEdge = '\000\300\000\000',
	PowerpointMSETSoftEdgeType1 = '\000\300\000\001',
	PowerpointMSETSoftEdgeType2 = '\000\300\000\002',
	PowerpointMSETSoftEdgeType3 = '\000\300\000\003',
	PowerpointMSETSoftEdgeType4 = '\000\300\000\004',
	PowerpointMSETSoftEdgeType5 = '\000\300\000\005',
	PowerpointMSETSoftEdgeType6 = '\000\300\000\006'
};
typedef enum PowerpointMSET PowerpointMSET;

enum PowerpointMCSI {
	PowerpointMCSIFirstDarkSchemeColor = '\000\301\000\001',
	PowerpointMCSIFirstLightSchemeColor = '\000\301\000\002',
	PowerpointMCSISecondDarkSchemeColor = '\000\301\000\003',
	PowerpointMCSISecondLightSchemeColor = '\000\301\000\004',
	PowerpointMCSIFirstAccentSchemeColor = '\000\301\000\005',
	PowerpointMCSISecondAccentSchemeColor = '\000\301\000\006',
	PowerpointMCSIThirdAccentSchemeColor = '\000\301\000\007',
	PowerpointMCSIFourthAccentSchemeColor = '\000\301\000\010',
	PowerpointMCSIFifthAccentSchemeColor = '\000\301\000\011',
	PowerpointMCSISixthAccentSchemeColor = '\000\301\000\012',
	PowerpointMCSIHyperlinkSchemeColor = '\000\301\000\013',
	PowerpointMCSIFollowedHyperlinkSchemeColor = '\000\301\000\014'
};
typedef enum PowerpointMCSI PowerpointMCSI;

enum PowerpointMCoI {
	PowerpointMCoIThemeColorUnset = '\000\301\377\376',
	PowerpointMCoINoThemeColor = '\000\302\000\000',
	PowerpointMCoIFirstDarkThemeColor = '\000\302\000\001',
	PowerpointMCoIFirstLightThemeColor = '\000\302\000\002',
	PowerpointMCoISecondDarkThemeColor = '\000\302\000\003',
	PowerpointMCoISecondLightThemeColor = '\000\302\000\004',
	PowerpointMCoIFirstAccentThemeColor = '\000\302\000\005',
	PowerpointMCoISecondAccentThemeColor = '\000\302\000\006',
	PowerpointMCoIThirdAccentThemeColor = '\000\302\000\007',
	PowerpointMCoIFourthAccentThemeColor = '\000\302\000\010',
	PowerpointMCoIFifthAccentThemeColor = '\000\302\000\011',
	PowerpointMCoISixthAccentThemeColor = '\000\302\000\012',
	PowerpointMCoIHyperlinkThemeColor = '\000\302\000\013',
	PowerpointMCoIFollowedHyperlinkThemeColor = '\000\302\000\014',
	PowerpointMCoIFirstTextThemeColor = '\000\302\000\015',
	PowerpointMCoIFirstBackgroundThemeColor = '\000\302\000\016',
	PowerpointMCoISecondTextThemeColor = '\000\302\000\017',
	PowerpointMCoISecondBackgroundThemeColor = '\000\302\000\020'
};
typedef enum PowerpointMCoI PowerpointMCoI;

enum PowerpointMFLI {
	PowerpointMFLIThemeFontLatin = '\000\303\000\001',
	PowerpointMFLIThemeFontComplexScript = '\000\303\000\002',
	PowerpointMFLIThemeFontHighAnsi = '\000\303\000\003',
	PowerpointMFLIThemeFontEastAsian = '\000\303\000\004'
};
typedef enum PowerpointMFLI PowerpointMFLI;

enum PowerpointMSSI {
	PowerpointMSSIShapeStyleUnset = '\000\303\377\376',
	PowerpointMSSIShapeNotAPreset = '\000\304\000\000',
	PowerpointMSSIShapePreset1 = '\000\304\000\001',
	PowerpointMSSIShapePreset2 = '\000\304\000\002',
	PowerpointMSSIShapePreset3 = '\000\304\000\003',
	PowerpointMSSIShapePreset4 = '\000\304\000\004',
	PowerpointMSSIShapePreset5 = '\000\304\000\005',
	PowerpointMSSIShapePreset6 = '\000\304\000\006',
	PowerpointMSSIShapePreset7 = '\000\304\000\007',
	PowerpointMSSIShapePreset8 = '\000\304\000\010',
	PowerpointMSSIShapePreset9 = '\000\304\000\011',
	PowerpointMSSIShapePreset10 = '\000\304\000\012',
	PowerpointMSSIShapePreset11 = '\000\304\000\013',
	PowerpointMSSIShapePreset12 = '\000\304\000\014',
	PowerpointMSSIShapePreset13 = '\000\304\000\015',
	PowerpointMSSIShapePreset14 = '\000\304\000\016',
	PowerpointMSSIShapePreset15 = '\000\304\000\017',
	PowerpointMSSIShapePreset16 = '\000\304\000\020',
	PowerpointMSSIShapePreset17 = '\000\304\000\021',
	PowerpointMSSIShapePreset18 = '\000\304\000\022',
	PowerpointMSSIShapePreset19 = '\000\304\000\023',
	PowerpointMSSIShapePreset20 = '\000\304\000\024',
	PowerpointMSSIShapePreset21 = '\000\304\000\025',
	PowerpointMSSIShapePreset22 = '\000\304\000\026',
	PowerpointMSSIShapePreset23 = '\000\304\000\027',
	PowerpointMSSIShapePreset24 = '\000\304\000\030',
	PowerpointMSSIShapePreset25 = '\000\304\000\031',
	PowerpointMSSIShapePreset26 = '\000\304\000\032',
	PowerpointMSSIShapePreset27 = '\000\304\000\033',
	PowerpointMSSIShapePreset28 = '\000\304\000\034',
	PowerpointMSSIShapePreset29 = '\000\304\000\035',
	PowerpointMSSIShapePreset30 = '\000\304\000\036',
	PowerpointMSSIShapePreset31 = '\000\304\000\037',
	PowerpointMSSIShapePreset32 = '\000\304\000 ',
	PowerpointMSSIShapePreset33 = '\000\304\000!',
	PowerpointMSSIShapePreset34 = '\000\304\000\"',
	PowerpointMSSIShapePreset35 = '\000\304\000#',
	PowerpointMSSIShapePreset36 = '\000\304\000$',
	PowerpointMSSIShapePreset37 = '\000\304\000%',
	PowerpointMSSIShapePreset38 = '\000\304\000&',
	PowerpointMSSIShapePreset39 = '\000\304\000\'',
	PowerpointMSSIShapePreset40 = '\000\304\000(',
	PowerpointMSSIShapePreset41 = '\000\304\000)',
	PowerpointMSSIShapePreset42 = '\000\304\000*',
	PowerpointMSSILinePreset1 = '\000\304\'\021',
	PowerpointMSSILinePreset2 = '\000\304\'\022',
	PowerpointMSSILinePreset3 = '\000\304\'\023',
	PowerpointMSSILinePreset4 = '\000\304\'\024',
	PowerpointMSSILinePreset5 = '\000\304\'\025',
	PowerpointMSSILinePreset6 = '\000\304\'\026',
	PowerpointMSSILinePreset7 = '\000\304\'\027',
	PowerpointMSSILinePreset8 = '\000\304\'\030',
	PowerpointMSSILinePreset9 = '\000\304\'\031',
	PowerpointMSSILinePreset10 = '\000\304\'\032',
	PowerpointMSSILinePreset11 = '\000\304\'\033',
	PowerpointMSSILinePreset12 = '\000\304\'\034',
	PowerpointMSSILinePreset13 = '\000\304\'\035',
	PowerpointMSSILinePreset14 = '\000\304\'\036',
	PowerpointMSSILinePreset15 = '\000\304\'\037',
	PowerpointMSSILinePreset16 = '\000\304\' ',
	PowerpointMSSILinePreset17 = '\000\304\'!',
	PowerpointMSSILinePreset18 = '\000\304\'\"',
	PowerpointMSSILinePreset19 = '\000\304\'#',
	PowerpointMSSILinePreset20 = '\000\304\'$',
	PowerpointMSSILinePreset21 = '\000\304\'%'
};
typedef enum PowerpointMSSI PowerpointMSSI;

enum PowerpointMBSI {
	PowerpointMBSIBackgroundUnset = '\000\304\377\376',
	PowerpointMBSIBackgroundNotAPreset = '\000\305\000\000',
	PowerpointMBSIBackgroundPreset1 = '\000\305\000\001',
	PowerpointMBSIBackgroundPreset2 = '\000\305\000\002',
	PowerpointMBSIBackgroundPreset3 = '\000\305\000\003',
	PowerpointMBSIBackgroundPreset4 = '\000\305\000\004',
	PowerpointMBSIBackgroundPreset5 = '\000\305\000\005',
	PowerpointMBSIBackgroundPreset6 = '\000\305\000\006',
	PowerpointMBSIBackgroundPreset7 = '\000\305\000\007',
	PowerpointMBSIBackgroundPreset8 = '\000\305\000\010',
	PowerpointMBSIBackgroundPreset9 = '\000\305\000\011',
	PowerpointMBSIBackgroundPreset10 = '\000\305\000\012',
	PowerpointMBSIBackgroundPreset11 = '\000\305\000\013',
	PowerpointMBSIBackgroundPreset12 = '\000\305\000\014'
};
typedef enum PowerpointMBSI PowerpointMBSI;

enum PowerpointPDrT {
	PowerpointPDrTTextDirectionUnset = '\000\352\377\376',
	PowerpointPDrTLeftToRight = '\000\353\000\001',
	PowerpointPDrTRightToLeft = '\000\353\000\002'
};
typedef enum PowerpointPDrT PowerpointPDrT;

enum PowerpointPBtT {
	PowerpointPBtTBulletTypeUnset = '\000\347\377\376',
	PowerpointPBtTBulletTypeNone = '\000\350\000\000',
	PowerpointPBtTBulletTypeUnnumbered = '\000\350\000\001',
	PowerpointPBtTBulletTypeNumbered = '\000\350\000\002',
	PowerpointPBtTPictureBulletType = '\000\350\000\003'
};
typedef enum PowerpointPBtT PowerpointPBtT;

enum PowerpointPBtS {
	PowerpointPBtSNumberedBulletStyleUnset = '\000\350\377\376',
	PowerpointPBtSNumberedBulletStyleAlphaLowercasePeriod = '\000\351\000\000',
	PowerpointPBtSNumberedBulletStyleAlphaUppercasePeriod = '\000\351\000\001',
	PowerpointPBtSNumberedBulletStyleArabicRightParen = '\000\351\000\002',
	PowerpointPBtSNumberedBulletStyleArabicPeriod = '\000\351\000\003',
	PowerpointPBtSNumberedBulletStyleRomanLowercaseParenBoth = '\000\351\000\004',
	PowerpointPBtSNumberedBulletStyleRomanLowercaseParenRight = '\000\351\000\005',
	PowerpointPBtSNumberedBulletStyleRomanLowercasePeriod = '\000\351\000\006',
	PowerpointPBtSNumberedBulletStyleRomanUppercasePeriod = '\000\351\000\007',
	PowerpointPBtSNumberedBulletStyleAlphaLowercaseParenBoth = '\000\351\000\010',
	PowerpointPBtSNumberedBulletStyleAlphaLowercaseParenRight = '\000\351\000\011',
	PowerpointPBtSNumberedBulletStyleAlphaUppercaseParenBoth = '\000\351\000\012',
	PowerpointPBtSNumberedBulletStyleAlphaUppercaseParenRight = '\000\351\000\013',
	PowerpointPBtSNumberedBulletStyleArabicParenBoth = '\000\351\000\014',
	PowerpointPBtSNumberedBulletStyleArabicPlain = '\000\351\000\015',
	PowerpointPBtSNumberedBulletStyleRomanUppercaseParenBoth = '\000\351\000\016',
	PowerpointPBtSNumberedBulletStyleRomanUppercaseParenRight = '\000\351\000\017',
	PowerpointPBtSNumberedBulletStyleSimplifiedChinesePlain = '\000\351\000\020',
	PowerpointPBtSNumberedBulletStyleSimplifiedChinesePeriod = '\000\351\000\021',
	PowerpointPBtSNumberedBulletStyleCircleNumberPlain = '\000\351\000\022',
	PowerpointPBtSNumberedBulletStyleCircleNumberWhitePlain = '\000\351\000\023',
	PowerpointPBtSNumberedBulletStyleCircleNumberBlackPlain = '\000\351\000\024',
	PowerpointPBtSNumberedBulletStyleTraditionalChinesePlain = '\000\351\000\025',
	PowerpointPBtSNumberedBulletStyleTraditionalChinesePeriod = '\000\351\000\026',
	PowerpointPBtSNumberedBulletStyleArabicAlphaDash = '\000\351\000\027',
	PowerpointPBtSNumberedBulletStyleArabicAbjadDash = '\000\351\000\030',
	PowerpointPBtSNumberedBulletStyleHebrewAlphaDash = '\000\351\000\031',
	PowerpointPBtSNumberedBulletStyleKanjiKoreanPlain = '\000\351\000\032',
	PowerpointPBtSNumberedBulletStyleKanjiKoreanPeriod = '\000\351\000\033',
	PowerpointPBtSNumberedBulletStyleArabicDBPlain = '\000\351\000\034',
	PowerpointPBtSNumberedBulletStyleArabicDBPeriod = '\000\351\000\035',
	PowerpointPBtSNumberedBulletStyleThaiAlphaPeriod = '\000\351\000\036',
	PowerpointPBtSNumberedBulletStyleThaiAlphaParenRight = '\000\351\000\037',
	PowerpointPBtSNumberedBulletStyleThaiAlphaParenBoth = '\000\351\000 ',
	PowerpointPBtSNumberedBulletStyleThaiNumberPeriod = '\000\351\000!',
	PowerpointPBtSNumberedBulletStyleThaiNumberParenRight = '\000\351\000\"',
	PowerpointPBtSNumberedBulletStyleThaiParenBoth = '\000\351\000#',
	PowerpointPBtSNumberedBulletStyleHindiAlphaPeriod = '\000\351\000$',
	PowerpointPBtSNumberedBulletStyleHindiNumberPeriod = '\000\351\000%',
	PowerpointPBtSNumberedBulletStyleKanjiSimpifiedChineseDBPeriod = '\000\351\000&',
	PowerpointPBtSNumberedBulletStyleHindiNumberParenRight = '\000\351\000\'',
	PowerpointPBtSNumberedBulletStyleHindiAlpha1Period = '\000\351\000('
};
typedef enum PowerpointPBtS PowerpointPBtS;

enum PowerpointPTSp {
	PowerpointPTSpTabstopUnset = '\000\364\377\376',
	PowerpointPTSpTabstopLeft = '\000\365\000\001',
	PowerpointPTSpTabstopCenter = '\000\365\000\002',
	PowerpointPTSpTabstopRight = '\000\365\000\003',
	PowerpointPTSpTabstopDecimal = '\000\365\000\004'
};
typedef enum PowerpointPTSp PowerpointPTSp;

enum PowerpointMRfT {
	PowerpointMRfTReflectionUnset = '\003\351\377\376',
	PowerpointMRfTReflectionTypeNone = '\003\352\000\000',
	PowerpointMRfTReflectionType1 = '\003\352\000\001',
	PowerpointMRfTReflectionType2 = '\003\352\000\002',
	PowerpointMRfTReflectionType3 = '\003\352\000\003',
	PowerpointMRfTReflectionType4 = '\003\352\000\004',
	PowerpointMRfTReflectionType5 = '\003\352\000\005',
	PowerpointMRfTReflectionType6 = '\003\352\000\006',
	PowerpointMRfTReflectionType7 = '\003\352\000\007',
	PowerpointMRfTReflectionType8 = '\003\352\000\010',
	PowerpointMRfTReflectionType9 = '\003\352\000\011'
};
typedef enum PowerpointMRfT PowerpointMRfT;

enum PowerpointMTtA {
	PowerpointMTtATextureUnset = '\003\352\377\376',
	PowerpointMTtATextureTopLeft = '\003\353\000\000',
	PowerpointMTtATextureTop = '\003\353\000\001',
	PowerpointMTtATextureTopRight = '\003\353\000\002',
	PowerpointMTtATextureLeft = '\003\353\000\003',
	PowerpointMTtATextureCenter = '\003\353\000\004',
	PowerpointMTtATextureRight = '\003\353\000\005',
	PowerpointMTtATextureBottomLeft = '\003\353\000\006',
	PowerpointMTtATextureBotton = '\003\353\000\007',
	PowerpointMTtATextureBottomRight = '\003\353\000\010'
};
typedef enum PowerpointMTtA PowerpointMTtA;

enum PowerpointPBlA {
	PowerpointPBlABaselineAlignmentUnset = '\003\353\377\376',
	PowerpointPBlABaselineAlignBaseline = '\003\354\000\001',
	PowerpointPBlABaselineAlignTop = '\003\354\000\002',
	PowerpointPBlABaselineAlignCenter = '\003\354\000\003',
	PowerpointPBlABaselineAlignEastAsian50 = '\003\354\000\004',
	PowerpointPBlABaselineAlignAutomatic = '\003\354\000\005'
};
typedef enum PowerpointPBlA PowerpointPBlA;

enum PowerpointMCbF {
	PowerpointMCbFClipboardFormatUnset = '\003\354\377\376',
	PowerpointMCbFNativeClipboardFormat = '\003\355\000\001',
	PowerpointMCbFHTMlClipboardFormat = '\003\355\000\002',
	PowerpointMCbFRTFClipboardFormat = '\003\355\000\003',
	PowerpointMCbFPlainTextClipboardFormat = '\003\355\000\004'
};
typedef enum PowerpointMCbF PowerpointMCbF;

enum PowerpointMTiP {
	PowerpointMTiPInsertBefore = '\003\356\000\000',
	PowerpointMTiPInsertAfter = '\003\356\000\001'
};
typedef enum PowerpointMTiP PowerpointMTiP;

enum PowerpointMPiT {
	PowerpointMPiTSaveAsDefault = '\003\362\377\376',
	PowerpointMPiTSaveAsPNGFile = '\003\363\000\000',
	PowerpointMPiTSaveAsBMPFile = '\003\363\000\001',
	PowerpointMPiTSaveAsGIFFile = '\003\363\000\002',
	PowerpointMPiTSaveAsJPGFile = '\003\363\000\003',
	PowerpointMPiTSaveAsPDFFile = '\003\363\000\004'
};
typedef enum PowerpointMPiT PowerpointMPiT;

enum PowerpointMOrT {
	PowerpointMOrTOrientationUnset = '\000\214\377\376',
	PowerpointMOrTHorizontalOrientation = '\000\215\000\001',
	PowerpointMOrTVerticalOrientation = '\000\215\000\002'
};
typedef enum PowerpointMOrT PowerpointMOrT;

enum PowerpointMZoC {
	PowerpointMZoCBringShapeToFront = '\000p\000\000',
	PowerpointMZoCSendShapeToBack = '\000p\000\001',
	PowerpointMZoCBringShapeForward = '\000p\000\002',
	PowerpointMZoCSendShapeBackward = '\000p\000\003',
	PowerpointMZoCBringShapeInFrontOfText = '\000p\000\004',
	PowerpointMZoCSendShapeBehindText = '\000p\000\005'
};
typedef enum PowerpointMZoC PowerpointMZoC;

enum PowerpointMSgT {
	PowerpointMSgTLine = '\000\217\000\000',
	PowerpointMSgTCurve = '\000\217\000\001'
};
typedef enum PowerpointMSgT PowerpointMSgT;

enum PowerpointMEdT {
	PowerpointMEdTAuto = '\000\220\000\000',
	PowerpointMEdTCorner = '\000\220\000\001',
	PowerpointMEdTSmooth = '\000\220\000\002',
	PowerpointMEdTSymmetric = '\000\220\000\003'
};
typedef enum PowerpointMEdT PowerpointMEdT;

enum PowerpointMFlC {
	PowerpointMFlCFlipHorizontal = '\000q\000\000',
	PowerpointMFlCFlipVertical = '\000q\000\001'
};
typedef enum PowerpointMFlC PowerpointMFlC;

enum PowerpointMTri {
	PowerpointMTriTrue = '\000\240\377\377',
	PowerpointMTriFalse = '\000\241\000\000',
	PowerpointMTriCTrue = '\000\241\000\001',
	PowerpointMTriToggle = '\000\240\377\375',
	PowerpointMTriTriStateUnset = '\000\240\377\376'
};
typedef enum PowerpointMTri PowerpointMTri;

enum PowerpointMBW {
	PowerpointMBWBlackAndWhiteUnset = '\000\254\377\376',
	PowerpointMBWBlackAndWhiteModeAutomatic = '\000\255\000\001',
	PowerpointMBWBlackAndWhiteModeGrayScale = '\000\255\000\002',
	PowerpointMBWBlackAndWhiteModeLightGrayScale = '\000\255\000\003',
	PowerpointMBWBlackAndWhiteModeInverseGrayScale = '\000\255\000\004',
	PowerpointMBWBlackAndWhiteModeGrayOutline = '\000\255\000\005',
	PowerpointMBWBlackAndWhiteModeBlackTextAndLine = '\000\255\000\006',
	PowerpointMBWBlackAndWhiteModeHighContrast = '\000\255\000\007',
	PowerpointMBWBlackAndWhiteModeBlack = '\000\255\000\010',
	PowerpointMBWBlackAndWhiteModeWhite = '\000\255\000\011',
	PowerpointMBWBlackAndWhiteModeDontShow = '\000\255\000\012'
};
typedef enum PowerpointMBW PowerpointMBW;

enum PowerpointMBPS {
	PowerpointMBPSBarLeft = '\000r\000\000',
	PowerpointMBPSBarTop = '\000r\000\001',
	PowerpointMBPSBarRight = '\000r\000\002',
	PowerpointMBPSBarBottom = '\000r\000\003',
	PowerpointMBPSBarFloating = '\000r\000\004',
	PowerpointMBPSBarPopUp = '\000r\000\005',
	PowerpointMBPSBarMenu = '\000r\000\006'
};
typedef enum PowerpointMBPS PowerpointMBPS;

enum PowerpointMBPt {
	PowerpointMBPtNoProtection = '\000s\000\000',
	PowerpointMBPtNoCustomize = '\000s\000\001',
	PowerpointMBPtNoResize = '\000s\000\002',
	PowerpointMBPtNoMove = '\000s\000\004',
	PowerpointMBPtNoChangeVisible = '\000s\000\010',
	PowerpointMBPtNoChangeDock = '\000s\000\020',
	PowerpointMBPtNoVerticalDock = '\000s\000 ',
	PowerpointMBPtNoHorizontalDock = '\000s\000@'
};
typedef enum PowerpointMBPt PowerpointMBPt;

enum PowerpointMBTY {
	PowerpointMBTYNormalCommandBar = '\000t\000\000',
	PowerpointMBTYMenubarCommandBar = '\000t\000\001',
	PowerpointMBTYPopupCommandBar = '\000t\000\002'
};
typedef enum PowerpointMBTY PowerpointMBTY;

enum PowerpointMCLT {
	PowerpointMCLTControlCustom = '\000u\000\000',
	PowerpointMCLTControlButton = '\000u\000\001',
	PowerpointMCLTControlEdit = '\000u\000\002',
	PowerpointMCLTControlDropDown = '\000u\000\003',
	PowerpointMCLTControlCombobox = '\000u\000\004',
	PowerpointMCLTButtonDropDown = '\000u\000\005',
	PowerpointMCLTSplitDropDown = '\000u\000\006',
	PowerpointMCLTOCXDropDown = '\000u\000\007',
	PowerpointMCLTGenericDropDown = '\000u\000\010',
	PowerpointMCLTGraphicDropDown = '\000u\000\011',
	PowerpointMCLTControlPopup = '\000u\000\012',
	PowerpointMCLTGraphicPopup = '\000u\000\013',
	PowerpointMCLTButtonPopup = '\000u\000\014',
	PowerpointMCLTSplitButtonPopup = '\000u\000\015',
	PowerpointMCLTSplitButtonMRUPopup = '\000u\000\016',
	PowerpointMCLTControlLabel = '\000u\000\017',
	PowerpointMCLTExpandingGrid = '\000u\000\020',
	PowerpointMCLTSplitExpandingGrid = '\000u\000\021',
	PowerpointMCLTControlGrid = '\000u\000\022',
	PowerpointMCLTControlGauge = '\000u\000\023',
	PowerpointMCLTGraphicCombobox = '\000u\000\024',
	PowerpointMCLTControlPane = '\000u\000\025',
	PowerpointMCLTActiveX = '\000u\000\026',
	PowerpointMCLTControlGroup = '\000u\000\027',
	PowerpointMCLTControlTab = '\000u\000\030',
	PowerpointMCLTControlSpinner = '\000u\000\031'
};
typedef enum PowerpointMCLT PowerpointMCLT;

enum PowerpointMBns {
	PowerpointMBnsButtonStateUp = '\000v\000\000',
	PowerpointMBnsButtonStateDown = '\000u\377\377',
	PowerpointMBnsButtonStateUnset = '\000v\000\002'
};
typedef enum PowerpointMBns PowerpointMBns;

enum PowerpointMcOu {
	PowerpointMcOuNeither = '\000w\000\000',
	PowerpointMcOuServer = '\000w\000\001',
	PowerpointMcOuClient = '\000w\000\002',
	PowerpointMcOuBoth = '\000w\000\003'
};
typedef enum PowerpointMcOu PowerpointMcOu;

enum PowerpointMBTs {
	PowerpointMBTsButtonAutomatic = '\000x\000\000',
	PowerpointMBTsButtonIcon = '\000x\000\001',
	PowerpointMBTsButtonCaption = '\000x\000\002',
	PowerpointMBTsButtonIconAndCaption = '\000x\000\003'
};
typedef enum PowerpointMBTs PowerpointMBTs;

enum PowerpointMXcb {
	PowerpointMXcbComboboxStyleNormal = '\000y\000\000',
	PowerpointMXcbComboboxStyleLabel = '\000y\000\001'
};
typedef enum PowerpointMXcb PowerpointMXcb;

enum PowerpointMMNA {
	PowerpointMMNANone = '\000{\000\000',
	PowerpointMMNARandom = '\000{\000\001',
	PowerpointMMNAUnfold = '\000{\000\002',
	PowerpointMMNASlide = '\000{\000\003'
};
typedef enum PowerpointMMNA PowerpointMMNA;

enum PowerpointMHlT {
	PowerpointMHlTHyperlinkTypeTextRange = '\000\226\000\000',
	PowerpointMHlTHyperlinkTypeShape = '\000\226\000\001',
	PowerpointMHlTHyperlinkTypeInlineShape = '\000\226\000\002'
};
typedef enum PowerpointMHlT PowerpointMHlT;

enum PowerpointMXiM {
	PowerpointMXiMAppendString = '\000\256\000\000',
	PowerpointMXiMPostString = '\000\256\000\001'
};
typedef enum PowerpointMXiM PowerpointMXiM;

enum PowerpointMANT {
	PowerpointMANTIdle = '\000|\000\001',
	PowerpointMANTGreeting = '\000|\000\002',
	PowerpointMANTGoodbye = '\000|\000\003',
	PowerpointMANTBeginSpeaking = '\000|\000\004',
	PowerpointMANTCharacterSuccessMajor = '\000|\000\006',
	PowerpointMANTGetAttentionMajor = '\000|\000\013',
	PowerpointMANTGetAttentionMinor = '\000|\000\014',
	PowerpointMANTSearching = '\000|\000\015',
	PowerpointMANTPrinting = '\000|\000\022',
	PowerpointMANTGestureRight = '\000|\000\023',
	PowerpointMANTWritingNotingSomething = '\000|\000\026',
	PowerpointMANTWorkingAtSomething = '\000|\000\027',
	PowerpointMANTThinking = '\000|\000\030',
	PowerpointMANTSendingMail = '\000|\000\031',
	PowerpointMANTListensToComputer = '\000|\000\032',
	PowerpointMANTDisappear = '\000|\000\037',
	PowerpointMANTAppear = '\000|\000 ',
	PowerpointMANTGetArtsy = '\000|\000d',
	PowerpointMANTGetTechy = '\000|\000e',
	PowerpointMANTGetWizardy = '\000|\000f',
	PowerpointMANTCheckingSomething = '\000|\000g',
	PowerpointMANTLookDown = '\000|\000h',
	PowerpointMANTLookDownLeft = '\000|\000i',
	PowerpointMANTLookDownRight = '\000|\000j',
	PowerpointMANTLookLeft = '\000|\000k',
	PowerpointMANTLookRight = '\000|\000l',
	PowerpointMANTLookUp = '\000|\000m',
	PowerpointMANTLookUpLeft = '\000|\000n',
	PowerpointMANTLookUpRight = '\000|\000o',
	PowerpointMANTSaving = '\000|\000p',
	PowerpointMANTGestureDown = '\000|\000q',
	PowerpointMANTGestureLeft = '\000|\000r',
	PowerpointMANTGestureUp = '\000|\000s',
	PowerpointMANTEmptyTrash = '\000|\000t'
};
typedef enum PowerpointMANT PowerpointMANT;

enum PowerpointMBSt {
	PowerpointMBStButtonNone = '\000}\000\000',
	PowerpointMBStButtonOk = '\000}\000\001',
	PowerpointMBStButtonCancel = '\000}\000\002',
	PowerpointMBStButtonsOkCancel = '\000}\000\003',
	PowerpointMBStButtonsYesNo = '\000}\000\004',
	PowerpointMBStButtonsYesNoCancel = '\000}\000\005',
	PowerpointMBStButtonsBackClose = '\000}\000\006',
	PowerpointMBStButtonsNextClose = '\000}\000\007',
	PowerpointMBStButtonsBackNextClose = '\000}\000\010',
	PowerpointMBStButtonsRetryCancel = '\000}\000\011',
	PowerpointMBStButtonsAbortRetryIgnore = '\000}\000\012',
	PowerpointMBStButtonsSearchClose = '\000}\000\013',
	PowerpointMBStButtonsBackNextSnooze = '\000}\000\014',
	PowerpointMBStButtonsTipsOptionsClose = '\000}\000\015',
	PowerpointMBStButtonsYesAllNoCancel = '\000}\000\016'
};
typedef enum PowerpointMBSt PowerpointMBSt;

enum PowerpointMIct {
	PowerpointMIctIconNone = '\000~\000\000',
	PowerpointMIctIconApplication = '\000~\000\001',
	PowerpointMIctIconAlert = '\000~\000\002',
	PowerpointMIctIconTip = '\000~\000\003',
	PowerpointMIctIconAlertCritical = '\000~\000e',
	PowerpointMIctIconAlertWarning = '\000~\000g',
	PowerpointMIctIconAlertInfo = '\000~\000h'
};
typedef enum PowerpointMIct PowerpointMIct;

enum PowerpointMWAt {
	PowerpointMWAtInactive = '\000\202\000\000',
	PowerpointMWAtActive = '\000\202\000\001',
	PowerpointMWAtSuspend = '\000\202\000\002',
	PowerpointMWAtResume = '\000\202\000\003'
};
typedef enum PowerpointMWAt PowerpointMWAt;

enum PowerpointMeDP {
	PowerpointMeDPPropertyTypeNumber = '\000\242\000\001',
	PowerpointMeDPPropertyTypeBoolean = '\000\242\000\002',
	PowerpointMeDPPropertyTypeDate = '\000\242\000\003',
	PowerpointMeDPPropertyTypeString = '\000\242\000\004',
	PowerpointMeDPPropertyTypeFloat = '\000\242\000\005'
};
typedef enum PowerpointMeDP PowerpointMeDP;

enum PowerpointMASc {
	PowerpointMAScMsoAutomationSecurityLow = '\000\243\000\001',
	PowerpointMAScMsoAutomationSecurityByUI = '\000\243\000\002',
	PowerpointMAScMsoAutomationSecurityForceDisable = '\000\243\000\003'
};
typedef enum PowerpointMASc PowerpointMASc;

enum PowerpointMSsz {
	PowerpointMSszResolution544x376 = '\000\204\000\000',
	PowerpointMSszResolution640x480 = '\000\204\000\001',
	PowerpointMSszResolution720x512 = '\000\204\000\002',
	PowerpointMSszResolution800x600 = '\000\204\000\003',
	PowerpointMSszResolution1024x768 = '\000\204\000\004',
	PowerpointMSszResolution1152x882 = '\000\204\000\005',
	PowerpointMSszResolution1152x900 = '\000\204\000\006',
	PowerpointMSszResolution1280x1024 = '\000\204\000\007',
	PowerpointMSszResolution1600x1200 = '\000\204\000\010',
	PowerpointMSszResolution1800x1440 = '\000\204\000\011',
	PowerpointMSszResolution1920x1200 = '\000\204\000\012'
};
typedef enum PowerpointMSsz PowerpointMSsz;

enum PowerpointMChS {
	PowerpointMChSArabicCharacterSet = '\000\205\000\001',
	PowerpointMChSCyrillicCharacterSet = '\000\205\000\002',
	PowerpointMChSEnglishCharacterSet = '\000\205\000\003',
	PowerpointMChSGreekCharacterSet = '\000\205\000\004',
	PowerpointMChSHebrewCharacterSet = '\000\205\000\005',
	PowerpointMChSJapaneseCharacterSet = '\000\205\000\006',
	PowerpointMChSKoreanCharacterSet = '\000\205\000\007',
	PowerpointMChSMultilingualUnicodeCharacterSet = '\000\205\000\010',
	PowerpointMChSSimplifiedChineseCharacterSet = '\000\205\000\011',
	PowerpointMChSThaiCharacterSet = '\000\205\000\012',
	PowerpointMChSTraditionalChineseCharacterSet = '\000\205\000\013',
	PowerpointMChSVietnameseCharacterSet = '\000\205\000\014'
};
typedef enum PowerpointMChS PowerpointMChS;

enum PowerpointMtEn {
	PowerpointMtEnEncodingThai = '\000\213\003j',
	PowerpointMtEnEncodingJapaneseShiftJIS = '\000\213\003\244',
	PowerpointMtEnEncodingSimplifiedChinese = '\000\213\003\250',
	PowerpointMtEnEncodingKorean = '\000\213\003\265',
	PowerpointMtEnEncodingBig5TraditionalChinese = '\000\213\003\266',
	PowerpointMtEnEncodingLittleEndian = '\000\213\004\260',
	PowerpointMtEnEncodingBigEndian = '\000\213\004\261',
	PowerpointMtEnEncodingCentralEuropean = '\000\213\004\342',
	PowerpointMtEnEncodingCyrillic = '\000\213\004\343',
	PowerpointMtEnEncodingWestern = '\000\213\004\344',
	PowerpointMtEnEncodingGreek = '\000\213\004\345',
	PowerpointMtEnEncodingTurkish = '\000\213\004\346',
	PowerpointMtEnEncodingHebrew = '\000\213\004\347',
	PowerpointMtEnEncodingArabic = '\000\213\004\350',
	PowerpointMtEnEncodingBaltic = '\000\213\004\351',
	PowerpointMtEnEncodingVietnamese = '\000\213\004\352',
	PowerpointMtEnEncodingISO88591Latin1 = '\000\213o\257',
	PowerpointMtEnEncodingISO88592CentralEurope = '\000\213o\260',
	PowerpointMtEnEncodingISO88593Latin3 = '\000\213o\261',
	PowerpointMtEnEncodingISO88594Baltic = '\000\213o\262',
	PowerpointMtEnEncodingISO88595Cyrillic = '\000\213o\263',
	PowerpointMtEnEncodingISO88596Arabic = '\000\213o\264',
	PowerpointMtEnEncodingISO88597Greek = '\000\213o\265',
	PowerpointMtEnEncodingISO88598Hebrew = '\000\213o\266',
	PowerpointMtEnEncodingISO88599Turkish = '\000\213o\267',
	PowerpointMtEnEncodingISO885915Latin9 = '\000\213o\275',
	PowerpointMtEnEncodingISO2022JapaneseNoHalfWidthKatakana = '\000\213\304,',
	PowerpointMtEnEncodingISO2022JapaneseJISX02021984 = '\000\213\304-',
	PowerpointMtEnEncodingISO2022JapaneseJISX02011989 = '\000\213\304.',
	PowerpointMtEnEncodingISO2022KR = '\000\213\3041',
	PowerpointMtEnEncodingISO2022CNTraditionalChinese = '\000\213\3043',
	PowerpointMtEnEncodingISO2022CNSimplifiedChinese = '\000\213\3045',
	PowerpointMtEnEncodingMacRoman = '\000\213\'\020',
	PowerpointMtEnEncodingMacJapanese = '\000\213\'\021',
	PowerpointMtEnEncodingMacTraditionalChinese = '\000\213\'\022',
	PowerpointMtEnEncodingMacKorean = '\000\213\'\023',
	PowerpointMtEnEncodingMacArabic = '\000\213\'\024',
	PowerpointMtEnEncodingMacHebrew = '\000\213\'\025',
	PowerpointMtEnEncodingMacGreek1 = '\000\213\'\026',
	PowerpointMtEnEncodingMacCyrillic = '\000\213\'\027',
	PowerpointMtEnEncodingMacSimplifiedChineseGB2312 = '\000\213\'\030',
	PowerpointMtEnEncodingMacRomania = '\000\213\'\032',
	PowerpointMtEnEncodingMacUkraine = '\000\213\'!',
	PowerpointMtEnEncodingMacLatin2 = '\000\213\'-',
	PowerpointMtEnEncodingMacIcelandic = '\000\213\'_',
	PowerpointMtEnEncodingMacTurkish = '\000\213\'a',
	PowerpointMtEnEncodingMacCroatia = '\000\213\'b',
	PowerpointMtEnEncodingEBCDICUSCanada = '\000\213\000%',
	PowerpointMtEnEncodingEBCDICInternational = '\000\213\001\364',
	PowerpointMtEnEncodingEBCDICMultilingualROECELatin2 = '\000\213\003f',
	PowerpointMtEnEncodingEBCDICGreekModern = '\000\213\003k',
	PowerpointMtEnEncodingEBCDICTurkishLatin5 = '\000\213\004\002',
	PowerpointMtEnEncodingEBCDICGermany = '\000\213O1',
	PowerpointMtEnEncodingEBCDICDenmarkNorway = '\000\213O5',
	PowerpointMtEnEncodingEBCDICFinlandSweden = '\000\213O6',
	PowerpointMtEnEncodingEBCDICItaly = '\000\213O8',
	PowerpointMtEnEncodingEBCDICLatinAmericaSpain = '\000\213O<',
	PowerpointMtEnEncodingEBCDICUnitedKingdom = '\000\213O=',
	PowerpointMtEnEncodingEBCDICJapaneseKatakanaExtended = '\000\213OB',
	PowerpointMtEnEncodingEBCDICFrance = '\000\213OI',
	PowerpointMtEnEncodingEBCDICArabic = '\000\213O\304',
	PowerpointMtEnEncodingEBCDICGreek = '\000\213O\307',
	PowerpointMtEnEncodingEBCDICHebrew = '\000\213O\310',
	PowerpointMtEnEncodingEBCDICKoreanExtended = '\000\213Qa',
	PowerpointMtEnEncodingEBCDICThai = '\000\213Qf',
	PowerpointMtEnEncodingEBCDICIcelandic = '\000\213Q\207',
	PowerpointMtEnEncodingEBCDICTurkish = '\000\213Q\251',
	PowerpointMtEnEncodingEBCDICRussian = '\000\213Q\220',
	PowerpointMtEnEncodingEBCDICSerbianBulgarian = '\000\213R!',
	PowerpointMtEnEncodingEBCDICJapaneseKatakanaExtendedAndJapanese = '\000\213\306\362',
	PowerpointMtEnEncodingEBCDICUSCanadaAndJapanese = '\000\213\306\363',
	PowerpointMtEnEncodingEBCDICExtendedAndKorean = '\000\213\306\365',
	PowerpointMtEnEncodingEBCDICSimplifiedChineseExtendedAndSimplifiedChinese = '\000\213\306\367',
	PowerpointMtEnEncodingEBCDICUSCanadaAndTraditionalChinese = '\000\213\306\371',
	PowerpointMtEnEncodingEBCDICJapaneseLatinExtendedAndJapanese = '\000\213\306\373',
	PowerpointMtEnEncodingOEMUnitedStates = '\000\213\001\265',
	PowerpointMtEnEncodingOEMGreek = '\000\213\002\341',
	PowerpointMtEnEncodingOEMBaltic = '\000\213\003\007',
	PowerpointMtEnEncodingOEMMultilingualLatinI = '\000\213\003R',
	PowerpointMtEnEncodingOEMMultilingualLatinII = '\000\213\003T',
	PowerpointMtEnEncodingOEMCyrillic = '\000\213\003W',
	PowerpointMtEnEncodingOEMTurkish = '\000\213\003Y',
	PowerpointMtEnEncodingOEMPortuguese = '\000\213\003\\',
	PowerpointMtEnEncodingOEMIcelandic = '\000\213\003]',
	PowerpointMtEnEncodingOEMHebrew = '\000\213\003^',
	PowerpointMtEnEncodingOEMCanadianFrench = '\000\213\003_',
	PowerpointMtEnEncodingOEMArabic = '\000\213\003`',
	PowerpointMtEnEncodingOEMNordic = '\000\213\003a',
	PowerpointMtEnEncodingOEMCyrillicII = '\000\213\003b',
	PowerpointMtEnEncodingOEMModernGreek = '\000\213\003e',
	PowerpointMtEnEncodingEUCJapanese = '\000\213\312\334',
	PowerpointMtEnEncodingEUCChineseSimplifiedChinese = '\000\213\312\340',
	PowerpointMtEnEncodingEUCKorean = '\000\213\312\355',
	PowerpointMtEnEncodingEUCTaiwaneseTraditionalChinese = '\000\213\312\356',
	PowerpointMtEnEncodingDevanagari = '\000\213\336\252',
	PowerpointMtEnEncodingBengali = '\000\213\336\253',
	PowerpointMtEnEncodingTamil = '\000\213\336\254',
	PowerpointMtEnEncodingTelugu = '\000\213\336\255',
	PowerpointMtEnEncodingAssamese = '\000\213\336\256',
	PowerpointMtEnEncodingOriya = '\000\213\336\257',
	PowerpointMtEnEncodingKannada = '\000\213\336\260',
	PowerpointMtEnEncodingMalayalam = '\000\213\336\261',
	PowerpointMtEnEncodingGujarati = '\000\213\336\262',
	PowerpointMtEnEncodingPunjabi = '\000\213\336\263',
	PowerpointMtEnEncodingArabicASMO = '\000\213\002\304',
	PowerpointMtEnEncodingArabicTransparentASMO = '\000\213\002\320',
	PowerpointMtEnEncodingKoreanJohab = '\000\213\005Q',
	PowerpointMtEnEncodingTaiwanCNS = '\000\213N ',
	PowerpointMtEnEncodingTaiwanTCA = '\000\213N!',
	PowerpointMtEnEncodingTaiwanEten = '\000\213N\"',
	PowerpointMtEnEncodingTaiwanIBM5550 = '\000\213N#',
	PowerpointMtEnEncodingTaiwanTeletext = '\000\213N$',
	PowerpointMtEnEncodingTaiwanWang = '\000\213N%',
	PowerpointMtEnEncodingIA5IRV = '\000\213N\211',
	PowerpointMtEnEncodingIA5German = '\000\213N\212',
	PowerpointMtEnEncodingIA5Swedish = '\000\213N\213',
	PowerpointMtEnEncodingIA5Norwegian = '\000\213N\214',
	PowerpointMtEnEncodingUSASCII = '\000\213N\237',
	PowerpointMtEnEncodingT61 = '\000\213O%',
	PowerpointMtEnEncodingISO6937NonspacingAccent = '\000\213O-',
	PowerpointMtEnEncodingKOI8R = '\000\213Q\202',
	PowerpointMtEnEncodingExtAlphaLowercase = '\000\213R#',
	PowerpointMtEnEncodingKOI8U = '\000\213Uj',
	PowerpointMtEnEncodingEuropa3 = '\000\213qI',
	PowerpointMtEnEncodingHZGBSimplifiedChinese = '\000\213\316\310',
	PowerpointMtEnEncodingUTF7 = '\000\213\375\350',
	PowerpointMtEnEncodingUTF8 = '\000\213\375\351'
};
typedef enum PowerpointMtEn PowerpointMtEn;

enum Powerpoint4000 {
	Powerpoint4000CommandBar = 'msCB',
	Powerpoint4000CommandBarControl = 'mCBC'
};
typedef enum Powerpoint4000 Powerpoint4000;

enum PowerpointMHyT {
	PowerpointMHyTHyperlinkRange = '\000\310\000\000',
	PowerpointMHyTHyperlinkShape = '\000\310\000\001',
	PowerpointMHyTHyperlinkInlineShape = '\000\310\000\002'
};
typedef enum PowerpointMHyT PowerpointMHyT;

enum PowerpointPWnS {
	PowerpointPWnSWindowNormal = '\000\311\000\001',
	PowerpointPWnSWindowMinimized = '\000\311\000\002'
};
typedef enum PowerpointPWnS PowerpointPWnS;

enum PowerpointPArS {
	PowerpointPArSArrangeTiled = '\000\321\000\001',
	PowerpointPArSArrangeCascade = '\000\321\000\002'
};
typedef enum PowerpointPArS PowerpointPArS;

enum PowerpointPVTy {
	PowerpointPVTySlideView = '\000\312\000\001',
	PowerpointPVTyMasterView = '\000\312\000\002',
	PowerpointPVTyPageView = '\000\312\000\003',
	PowerpointPVTyHandoutMasterView = '\000\312\000\004',
	PowerpointPVTyNotesMasterView = '\000\312\000\005',
	PowerpointPVTyOutlineView = '\000\312\000\006',
	PowerpointPVTySlideSorterView = '\000\312\000\007',
	PowerpointPVTyTitleMasterView = '\000\312\000\010',
	PowerpointPVTyNormalView = '\000\312\000\011',
	PowerpointPVTyThumbnailView = '\000\312\000\012',
	PowerpointPVTyThumbnailMasterView = '\000\312\000\013'
};
typedef enum PowerpointPVTy PowerpointPVTy;

enum PowerpointPCSi {
	PowerpointPCSiSchemeColorUnset = '\000\362\377\376',
	PowerpointPCSiNotASchemeColor = '\000\363\000\000',
	PowerpointPCSiBackgroundScheme = '\000\363\000\001',
	PowerpointPCSiForegroundScheme = '\000\363\000\002',
	PowerpointPCSiShadowScheme = '\000\363\000\003',
	PowerpointPCSiTitleScheme = '\000\363\000\004',
	PowerpointPCSiFillScheme = '\000\363\000\005',
	PowerpointPCSiAccent1Scheme = '\000\363\000\006',
	PowerpointPCSiAccent2Scheme = '\000\363\000\007',
	PowerpointPCSiAccent3Scheme = '\000\363\000\010'
};
typedef enum PowerpointPCSi PowerpointPCSi;

enum PowerpointSSzT {
	PowerpointSSzTSlideSizeOnScreen = '\000\313\000\001',
	PowerpointSSzTSlideSizeLetterPaper = '\000\313\000\002',
	PowerpointSSzTSlideSizeA4Paper = '\000\313\000\003',
	PowerpointSSzTSlideSize35MM = '\000\313\000\004',
	PowerpointSSzTSlideSizeOverhead = '\000\313\000\005',
	PowerpointSSzTSlideSizeBanner = '\000\313\000\006',
	PowerpointSSzTSlideSizeCustom = '\000\313\000\007'
};
typedef enum PowerpointSSzT PowerpointSSzT;

enum PowerpointPSAT {
	PowerpointPSATSaveAsPresentation = '\000\314\000\001',
	PowerpointPSATSaveAsTemplate = '\000\314\000\005',
	PowerpointPSATSaveAsRTF = '\000\314\000\006',
	PowerpointPSATSaveAsShow = '\000\314\000\007',
	PowerpointPSATSaveAsDefault = '\000\314\000\012',
	PowerpointPSATSaveAsHTML = '\000\314\000\013',
	PowerpointPSATSaveAsMovie = '\000\314\000\014',
	PowerpointPSATSaveAsPackage = '\000\314\000\015',
	PowerpointPSATSaveAsPDF = '\000\314\000\016',
	PowerpointPSATSaveAsOpenXMLPresentation = '\000\314\000\017',
	PowerpointPSATSaveAsOpenXMLPresentationMacroEnabled = '\000\314\000\020',
	PowerpointPSATSaveAsOpenXMLShow = '\000\314\000\021',
	PowerpointPSATSaveAsOpenXMLShowMacroEnabled = '\000\314\000\022',
	PowerpointPSATSaveAsOpenXMLTemplate = '\000\314\000\023',
	PowerpointPSATSaveAsOpenXMLTemplateMacroEnabled = '\000\314\000\024',
	PowerpointPSATSaveAsOpenXMLTheme = '\000\314\000\025'
};
typedef enum PowerpointPSAT PowerpointPSAT;

enum PowerpointPTst {
	PowerpointPTstTextStyleDefault = '\001*\000\001',
	PowerpointPTstTextStyleTitle = '\001*\000\002',
	PowerpointPTstTextStyleBody = '\001*\000\003'
};
typedef enum PowerpointPTst PowerpointPTst;

enum PowerpointPSLo {
	PowerpointPSLoSlideLayoutUnset = '\000\314\377\376',
	PowerpointPSLoSlideLayoutTitleSlide = '\000\315\000\001',
	PowerpointPSLoSlideLayoutTextSlide = '\000\315\000\002',
	PowerpointPSLoSlideLayoutTwoColumnText = '\000\315\000\003',
	PowerpointPSLoSlideLayoutTable = '\000\315\000\004',
	PowerpointPSLoSlideLayoutTextAndChart = '\000\315\000\005',
	PowerpointPSLoSlideLayoutChartAndText = '\000\315\000\006',
	PowerpointPSLoSlideLayoutOrgchart = '\000\315\000\007',
	PowerpointPSLoSlideLayoutChart = '\000\315\000\010',
	PowerpointPSLoSlideLayoutTextAndClipart = '\000\315\000\011',
	PowerpointPSLoSlideLayoutClipartAndText = '\000\315\000\012',
	PowerpointPSLoSlideLayoutTitleOnly = '\000\315\000\013',
	PowerpointPSLoSlideLayoutBlank = '\000\315\000\014',
	PowerpointPSLoSlideLayoutTextAndObject = '\000\315\000\015',
	PowerpointPSLoSlideLayoutObjectAndText = '\000\315\000\016',
	PowerpointPSLoSlideLayoutLargeObject = '\000\315\000\017',
	PowerpointPSLoSlideLayoutObject = '\000\315\000\020',
	PowerpointPSLoSlideLayoutMediaClip = '\000\315\000\021',
	PowerpointPSLoSlideLayoutMediaClipAndText = '\000\315\000\022',
	PowerpointPSLoSlideLayoutObjectOverText = '\000\315\000\023',
	PowerpointPSLoSlideLayoutTextOverObject = '\000\315\000\024',
	PowerpointPSLoSlideLayoutTextAndTwoObjects = '\000\315\000\025',
	PowerpointPSLoSlideLayoutTwoObjectsAndText = '\000\315\000\026',
	PowerpointPSLoSlideLayoutTwoObjectsOverText = '\000\315\000\027',
	PowerpointPSLoSlideLayoutFourObjects = '\000\315\000\030',
	PowerpointPSLoSlideLayoutVerticalText = '\000\315\000\031',
	PowerpointPSLoSlideLayoutClipartAndVerticalText = '\000\315\000\032',
	PowerpointPSLoSlideLayoutVerticalTitleAndText = '\000\315\000\033',
	PowerpointPSLoSlideLayoutVerticalTitleAndTextOverChart = '\000\315\000\034',
	PowerpointPSLoSlideLayoutTwoObjects = '\000\315\000\035',
	PowerpointPSLoSlideLayoutObjectAndTwoObjects = '\000\315\000\036',
	PowerpointPSLoSlideLayoutTwoObjectsAndObject = '\000\315\000\037',
	PowerpointPSLoSlideLayoutCustom = '\000\315\000 ',
	PowerpointPSLoSlideLayoutSectionHeader = '\000\315\000!',
	PowerpointPSLoSlideLayoutComparison = '\000\315\000\"',
	PowerpointPSLoSlideLayoutContentWithCaption = '\000\315\000#',
	PowerpointPSLoSlideLayoutPictureWithCaption = '\000\315\000$'
};
typedef enum PowerpointPSLo PowerpointPSLo;

enum PowerpointPEeF {
	PowerpointPEeFEntryEffectUnset = '\000\365\377\376',
	PowerpointPEeFEntryEffectNone = '\000\366\000\000',
	PowerpointPEeFEntryEffectCut = '\000\366\001\001',
	PowerpointPEeFEntryEffectCutBlack = '\000\366\001\002',
	PowerpointPEeFEntryEffectRandom = '\000\366\002\001',
	PowerpointPEeFEntryEffectBlindsHorizontal = '\000\366\003\001',
	PowerpointPEeFEntryEffectBlindsVertical = '\000\366\003\002',
	PowerpointPEeFEntryEffectCheckerboardAcross = '\000\366\004\001',
	PowerpointPEeFEntryEffectCheckerboardDown = '\000\366\004\002',
	PowerpointPEeFEntryEffectCoverLeft = '\000\366\005\001',
	PowerpointPEeFEntryEffectCoverUp = '\000\366\005\002',
	PowerpointPEeFEntryEffectCoverRight = '\000\366\005\003',
	PowerpointPEeFEntryEffectCoverDown = '\000\366\005\004',
	PowerpointPEeFEntryEffectCoverLeftUp = '\000\366\005\005',
	PowerpointPEeFEntryEffectCoverRightUp = '\000\366\005\006',
	PowerpointPEeFEntryEffectCoverLeftDown = '\000\366\005\007',
	PowerpointPEeFEntryEffectCoverRightDown = '\000\366\005\010',
	PowerpointPEeFEntryEffectDissolve = '\000\366\006\001',
	PowerpointPEeFEntryEffectFadeBlack = '\000\366\007\001',
	PowerpointPEeFEntryEffectUncoverLeft = '\000\366\010\001',
	PowerpointPEeFEntryEffectUncoverUp = '\000\366\010\002',
	PowerpointPEeFEntryEffectUncoverRight = '\000\366\010\003',
	PowerpointPEeFEntryEffectUncoverDown = '\000\366\010\004',
	PowerpointPEeFEntryEffectUncoverLeftUp = '\000\366\010\005',
	PowerpointPEeFEntryEffectUncoverRightUp = '\000\366\010\006',
	PowerpointPEeFEntryEffectUncoverLeftDown = '\000\366\010\007',
	PowerpointPEeFEntryEffectUncoverRightDown = '\000\366\010\010',
	PowerpointPEeFEntryEffectRandomBarsHorizontal = '\000\366\011\001',
	PowerpointPEeFEntryEffectRandomBarsVertical = '\000\366\011\002',
	PowerpointPEeFEntryEffectStripsLeftUp = '\000\366\012\005',
	PowerpointPEeFEntryEffectStripsRightUp = '\000\366\012\006',
	PowerpointPEeFEntryEffectStripsLeftDown = '\000\366\012\007',
	PowerpointPEeFEntryEffectStripsRightDown = '\000\366\012\010',
	PowerpointPEeFEntryEffectWipeLeft = '\000\366\013\001',
	PowerpointPEeFEntryEffectWipeUp = '\000\366\013\002',
	PowerpointPEeFEntryEffectWipeRight = '\000\366\013\003',
	PowerpointPEeFEntryEffectWipeDown = '\000\366\013\004',
	PowerpointPEeFEntryEffectBoxOut = '\000\366\014\001',
	PowerpointPEeFEntryEffectBoxIn = '\000\366\014\002',
	PowerpointPEeFEntryEffectFlyFromLeft = '\000\366\015\001',
	PowerpointPEeFEntryEffectFlyFromTop = '\000\366\015\002',
	PowerpointPEeFEntryEffectFlyFromRight = '\000\366\015\003',
	PowerpointPEeFEntryEffectFlyFromBottom = '\000\366\015\004',
	PowerpointPEeFEntryEffectFlyFromTopLeft = '\000\366\015\005',
	PowerpointPEeFEntryEffectFlyFromTopRight = '\000\366\015\006',
	PowerpointPEeFEntryEffectFlyFromBottomLeft = '\000\366\015\007',
	PowerpointPEeFEntryEffectFlyFromBottomRight = '\000\366\015\010',
	PowerpointPEeFEntryEffectPeekFromLeft = '\000\366\015\011',
	PowerpointPEeFEntryEffectPeekFromDown = '\000\366\015\012',
	PowerpointPEeFEntryEffectPeekFromRight = '\000\366\015\013',
	PowerpointPEeFEntryEffectPeekFromUp = '\000\366\015\014',
	PowerpointPEeFEntryEffectCrawlFromLeft = '\000\366\015\015',
	PowerpointPEeFEntryEffectCrawlFromUp = '\000\366\015\016',
	PowerpointPEeFEntryEffectCrawlFromRight = '\000\366\015\017',
	PowerpointPEeFEntryEffectCrawlFromDown = '\000\366\015\020',
	PowerpointPEeFEntryEffectZoomIn = '\000\366\015\021',
	PowerpointPEeFEntryEffectZoomInSlightly = '\000\366\015\022',
	PowerpointPEeFEntryEffectZoomOut = '\000\366\015\023',
	PowerpointPEeFEntryEffectZoomOutSlightly = '\000\366\015\024',
	PowerpointPEeFEntryEffectZoomCenter = '\000\366\015\025',
	PowerpointPEeFEntryEffectZoomBottom = '\000\366\015\026',
	PowerpointPEeFEntryEffectStretchAcross = '\000\366\015\027',
	PowerpointPEeFEntryEffectCollapseAcross = '\000\366\015\027',
	PowerpointPEeFEntryEffectStretchLeft = '\000\366\015\030',
	PowerpointPEeFEntryEffectCollapseLeft = '\000\366\015\030',
	PowerpointPEeFEntryEffectStretchUp = '\000\366\015\031',
	PowerpointPEeFEntryEffectCollapseUp = '\000\366\015\031',
	PowerpointPEeFEntryEffectStretchRight = '\000\366\015\032',
	PowerpointPEeFEntryEffectCollapseRight = '\000\366\015\032',
	PowerpointPEeFEntryEffectStretchDown = '\000\366\015\033',
	PowerpointPEeFEntryEffectCollapseBottom = '\000\366\015\033',
	PowerpointPEeFEntryEffectSwivel = '\000\366\015\034',
	PowerpointPEeFEntryEffectSpiral = '\000\366\015\035',
	PowerpointPEeFEntryEffectFadeFlyFromLeft = '\000\366\015\036',
	PowerpointPEeFEntryEffectFadeFlyFromTop = '\000\366\015\037',
	PowerpointPEeFEntryEffectFadeFlyFromRight = '\000\366\015 ',
	PowerpointPEeFEntryEffectFadeFlyFromBottom = '\000\366\015!',
	PowerpointPEeFEntryEffectFadeFlyFromTopLeft = '\000\366\015\"',
	PowerpointPEeFEntryEffectFadeFlyFromTopRight = '\000\366\015#',
	PowerpointPEeFEntryEffectFadeFlyFromBottomLeft = '\000\366\015$',
	PowerpointPEeFEntryEffectFadeFlyFromBottomRight = '\000\366\015%',
	PowerpointPEeFEntryEffectSplitHorizontalOut = '\000\366\016\001',
	PowerpointPEeFEntryEffectSplitHorizontalIn = '\000\366\016\002',
	PowerpointPEeFEntryEffectSplitVerticalOut = '\000\366\016\003',
	PowerpointPEeFEntryEffectSplitVerticalIn = '\000\366\016\004',
	PowerpointPEeFEntryEffectFlashOnceFast = '\000\366\017\001',
	PowerpointPEeFEntryEffectFlashOnceMedium = '\000\366\017\002',
	PowerpointPEeFEntryEffectFlashOnceSlow = '\000\366\017\003',
	PowerpointPEeFEntryEffectAppear = '\000\366\017\004',
	PowerpointPEeFEntryEffectCircle = '\000\366\017\005',
	PowerpointPEeFEntryEffectDiamond = '\000\366\017\006',
	PowerpointPEeFEntryEffectCombHorizontal = '\000\366\017\007',
	PowerpointPEeFEntryEffectCombVertical = '\000\366\017\010',
	PowerpointPEeFEntryEffectFade = '\000\366\017\011',
	PowerpointPEeFEntryEffectFadeSmoothly = '\000\366\017\011',
	PowerpointPEeFEntryEffectNewsFlash = '\000\366\017\012',
	PowerpointPEeFEntryEffectSpinner = '\000\366\017\012',
	PowerpointPEeFEntryEffectPlus = '\000\366\017\013',
	PowerpointPEeFEntryEffectPushDown = '\000\366\017\014',
	PowerpointPEeFEntryEffectPushLeft = '\000\366\017\015',
	PowerpointPEeFEntryEffectPushRight = '\000\366\017\016',
	PowerpointPEeFEntryEffectPushUp = '\000\366\017\017',
	PowerpointPEeFEntryEffectWedge = '\000\366\017\020',
	PowerpointPEeFEntryEffectWheel1Spoke = '\000\366\017\021',
	PowerpointPEeFEntryEffectWheel2Spokes = '\000\366\017\022',
	PowerpointPEeFEntryEffectWheel3Spokes = '\000\366\017\023',
	PowerpointPEeFEntryEffectWheel4Spokes = '\000\366\017\024',
	PowerpointPEeFEntryEffectWheel8Spokes = '\000\366\017\025',
	PowerpointPEeFEntryEffectFlipLeft = '\000\366\017\201',
	PowerpointPEeFEntryEffectFlipRight = '\000\366\017\202',
	PowerpointPEeFEntryEffectFlipUp = '\000\366\017\203',
	PowerpointPEeFEntryEffectFlipDown = '\000\366\017\204',
	PowerpointPEeFEntryEffectCubeLeft = '\000\366\017\205',
	PowerpointPEeFEntryEffectCubeRight = '\000\366\017\206',
	PowerpointPEeFEntryEffectCubeUp = '\000\366\017\207',
	PowerpointPEeFEntryEffectCubeDown = '\000\366\017\210'
};
typedef enum PowerpointPEeF PowerpointPEeF;

enum PowerpointPTlE {
	PowerpointPTlEAnimationLevelUnset = '\000\337\377\376',
	PowerpointPTlEAnimateLevelNone = '\000\340\000\000',
	PowerpointPTlEAnimateLevelFirstLevel = '\000\340\000\001',
	PowerpointPTlEAnimateLevelSecondLevel = '\000\340\000\002',
	PowerpointPTlEAnimateLevelThirdLevel = '\000\340\000\003',
	PowerpointPTlEAnimateLevelFourthLevel = '\000\340\000\004',
	PowerpointPTlEAnimateLevelFifthLevel = '\000\340\000\005',
	PowerpointPTlEAnimateLevelAllLevels = '\000\340\000\020'
};
typedef enum PowerpointPTlE PowerpointPTlE;

enum PowerpointPTuE {
	PowerpointPTuEAnimationUnitUnset = '\000\340\377\376',
	PowerpointPTuETextUnitEffectByParagraph = '\000\341\000\000',
	PowerpointPTuETextUnitEffectByWord = '\000\341\000\001',
	PowerpointPTuETextUnitEffectByCharacter = '\000\341\000\002'
};
typedef enum PowerpointPTuE PowerpointPTuE;

enum PowerpointPCuE {
	PowerpointPCuEAnimationChartUnset = '\000\341\377\376',
	PowerpointPCuEChartUnitEffectBySeries = '\000\342\000\001',
	PowerpointPCuEChartUnitEffectByCategory = '\000\342\000\002',
	PowerpointPCuEChartUnitEffectBySeriesElement = '\000\342\000\003'
};
typedef enum PowerpointPCuE PowerpointPCuE;

enum PowerpointAsAe {
	PowerpointAsAeAfterEffectUnset = '\000\363\377\376',
	PowerpointAsAeAfterEffectNone = '\000\364\000\000',
	PowerpointAsAeAfterEffectHide = '\000\364\000\001',
	PowerpointAsAeAfterEffectDim = '\000\364\000\002'
};
typedef enum PowerpointAsAe PowerpointAsAe;

enum PowerpointAdMd {
	PowerpointAdMdAdvanceModeUnset = '\000\361\377\376',
	PowerpointAdMdAdvanceModeOnClick = '\000\362\000\001'
};
typedef enum PowerpointAdMd PowerpointAdMd;

enum PowerpointPSnX {
	PowerpointPSnXSoundEffectUnset = '\000\331\377\376',
	PowerpointPSnXSoundEffectNone = '\000\332\000\000',
	PowerpointPSnXSoundEffectStopPrevious = '\000\332\000\001',
	PowerpointPSnXSoundEffectFile = '\000\332\000\002'
};
typedef enum PowerpointPSnX PowerpointPSnX;

enum PowerpointPUdO {
	PowerpointPUdOUpdateOptionUnset = '\000\336\377\376',
	PowerpointPUdOUpdateOptionManual = '\000\337\000\001'
};
typedef enum PowerpointPUdO PowerpointPUdO;

enum PowerpointPDgM {
	PowerpointPDgMDialogModeUnset = '\000\357\377\376',
	PowerpointPDgMDialogModeModless = '\000\360\000\000',
	PowerpointPDgMDialogModeModal = '\000\360\000\001'
};
typedef enum PowerpointPDgM PowerpointPDgM;

enum PowerpointPDgS {
	PowerpointPDgSDialogStyleUnset = '\000\360\377\376',
	PowerpointPDgSDialogStyleStandard = '\000\361\000\001'
};
typedef enum PowerpointPDgS PowerpointPDgS;

enum PowerpointPSsP {
	PowerpointPSsPSlideShowPointerNone = '\000\322\000\000',
	PowerpointPSsPSlideShowPointerArrow = '\000\322\000\001',
	PowerpointPSsPSlideShowPointerPen = '\000\322\000\002',
	PowerpointPSsPSlideShowPointerAlwaysHidden = '\000\322\000\003'
};
typedef enum PowerpointPSsP PowerpointPSsP;

enum PowerpointPShS {
	PowerpointPShSSlideShowStateRunning = '\000\323\000\001',
	PowerpointPShSSlideShowStatePaused = '\000\323\000\002',
	PowerpointPShSSlideShowStateBlackScreen = '\000\323\000\003',
	PowerpointPShSSlideShowStateWhiteScreen = '\000\323\000\004'
};
typedef enum PowerpointPShS PowerpointPShS;

enum PowerpointPSaM {
	PowerpointPSaMSlideShowAdvanceManualAdvance = '\000\324\000\001',
	PowerpointPSaMSlideShowAdvanceUseSlideTimings = '\000\324\000\002'
};
typedef enum PowerpointPSaM PowerpointPSaM;

enum PowerpointPtOt {
	PowerpointPtOtPrintSlides = '\000\330\000\001',
	PowerpointPtOtPrintTwoSlideHandouts = '\000\330\000\002',
	PowerpointPtOtPrintThreeSlideHandouts = '\000\330\000\003',
	PowerpointPtOtPrintSixSlideHandouts = '\000\330\000\004',
	PowerpointPtOtPrintNotesPages = '\000\330\000\005',
	PowerpointPtOtPrintOutline = '\000\330\000\006',
	PowerpointPtOtPrintFourSlideHandouts = '\000\330\000\007',
	PowerpointPtOtPrintNineSlideHandouts = '\000\330\000\010'
};
typedef enum PowerpointPtOt PowerpointPtOt;

enum PowerpointPrCt {
	PowerpointPrCtPrintColor = '\000\327\000\001',
	PowerpointPrCtPrintBlackAndWhite = '\000\327\000\002'
};
typedef enum PowerpointPrCt PowerpointPrCt;

enum PowerpointPSEL {
	PowerpointPSELPpSelectionNone = '\000\316\000\000',
	PowerpointPSELPpSelectionSlides = '\000\316\000\001',
	PowerpointPSELPpSelectionShapes = '\000\316\000\002'
};
typedef enum PowerpointPSEL PowerpointPSEL;

enum PowerpointPDtF {
	PowerpointPDtFUnset = '\000\342\377\376',
	PowerpointPDtFMdyy = '\000\343\000\001',
	PowerpointPDtFDdddMMMMddyyyy = '\000\343\000\002',
	PowerpointPDtFMMMMyyyy = '\000\343\000\003',
	PowerpointPDtFMMMMdyyyy = '\000\343\000\004',
	PowerpointPDtFMMMyy = '\000\343\000\005',
	PowerpointPDtFMMMMyy = '\000\343\000\006',
	PowerpointPDtFMMyy = '\000\343\000\007',
	PowerpointPDtFMMddyyHmm = '\000\343\000\010',
	PowerpointPDtFMddyyhmmAMPM = '\000\343\000\011',
	PowerpointPDtFHmm = '\000\343\000\012',
	PowerpointPDtFHmmss = '\000\343\000\013',
	PowerpointPDtFHmmAMPM = '\000\343\000\014',
	PowerpointPDtFHmmssAMPM = '\000\343\000\015'
};
typedef enum PowerpointPDtF PowerpointPDtF;

enum PowerpointPTnS {
	PowerpointPTnSTransitionSpeedUnset = '\000\330\377\376',
	PowerpointPTnSTransistionSpeedSlow = '\000\331\000\001',
	PowerpointPTnSTransistionSpeedMedium = '\000\331\000\002'
};
typedef enum PowerpointPTnS PowerpointPTnS;

enum PowerpointPMtv {
	PowerpointPMtvMouseActivationMouseClick = '\000\372\000\001',
	PowerpointPMtvMouseActivationMouseOver = '\000\372\000\002'
};
typedef enum PowerpointPMtv PowerpointPMtv;

enum PowerpointPAxT {
	PowerpointPAxTActionTypeUnset = '\000\345\377\376',
	PowerpointPAxTActionTypeNone = '\000\346\000\000',
	PowerpointPAxTActionTypeNextSlide = '\000\346\000\001',
	PowerpointPAxTActionTypePreviousSlide = '\000\346\000\002',
	PowerpointPAxTActionTypeFirstSlide = '\000\346\000\003',
	PowerpointPAxTActionTypeLastSlide = '\000\346\000\004',
	PowerpointPAxTActionTypeLastSlideViewed = '\000\346\000\005',
	PowerpointPAxTActionTypeEndShow = '\000\346\000\006',
	PowerpointPAxTActionTypeHyperlinkAction = '\000\346\000\007',
	PowerpointPAxTActionTypeRunMacro = '\000\346\000\010',
	PowerpointPAxTActionTypeRunProgram = '\000\346\000\011',
	PowerpointPAxTActionTypeNamedSlideshowAction = '\000\346\000\012',
	PowerpointPAxTActionTypeOLEVerb = '\000\346\000\013'
};
typedef enum PowerpointPAxT PowerpointPAxT;

enum PowerpointPPhd {
	PowerpointPPhdPlaceholderTypeUnset = '\000\332\377\376',
	PowerpointPPhdPlaceholderTypeTitlePlaceholder = '\000\333\000\001',
	PowerpointPPhdPlaceholderTypeBodyPlaceholder = '\000\333\000\002',
	PowerpointPPhdPlaceholderTypeCenterTitlePlaceholder = '\000\333\000\003',
	PowerpointPPhdPlaceholderTypeSubtitlePlaceholder = '\000\333\000\004',
	PowerpointPPhdPlaceholderTypeVerticalTitlePlaceholder = '\000\333\000\005',
	PowerpointPPhdPlaceholderTypeVerticalBodyPlaceholder = '\000\333\000\006',
	PowerpointPPhdPlaceholderTypeObjectPlaceholder = '\000\333\000\007',
	PowerpointPPhdPlaceholderTypeChartPlaceholder = '\000\333\000\010',
	PowerpointPPhdPlaceholderTypeBitmapPlaceholder = '\000\333\000\011',
	PowerpointPPhdPlaceholderTypeMediaClipPlaceholder = '\000\333\000\012',
	PowerpointPPhdPlaceholderTypeOrgChartPlaceholder = '\000\333\000\013',
	PowerpointPPhdPlaceholderTypeTablePlaceholder = '\000\333\000\014',
	PowerpointPPhdPlaceholderTypeSlideNumberPlaceholder = '\000\333\000\015',
	PowerpointPPhdPlaceholderTypeHeaderPlaceholder = '\000\333\000\016',
	PowerpointPPhdPlaceholderTypeFooterPlaceholder = '\000\333\000\017',
	PowerpointPPhdPlaceholderTypeDatePlaceholder = '\000\333\000\020',
	PowerpointPPhdPlaceholderTypeVerticalObjectPlaceholder = '\000\333\000\021',
	PowerpointPPhdPlaceholderTypePicturePlaceholder = '\000\333\000\022'
};
typedef enum PowerpointPPhd PowerpointPPhd;

enum PowerpointPSSt {
	PowerpointPSStSlideShowTypeSpeaker = '\000\325\000\001',
	PowerpointPSStSlideShowTypeWindow = '\000\325\000\002',
	PowerpointPSStSlideShowTypePresenter = '\000\325\000\003',
	PowerpointPSStSlideShowTypeKiosk = '\000\325\000\004'
};
typedef enum PowerpointPSSt PowerpointPSSt;

enum PowerpointRgTy {
	PowerpointRgTyPrintRangeAll = '\000\367\000\001',
	PowerpointRgTyPrintRangeSelection = '\000\367\000\002',
	PowerpointRgTyPrintRangeCurrent = '\000\367\000\003',
	PowerpointRgTyPrintRangeSlideRange = '\000\367\000\004'
};
typedef enum PowerpointRgTy PowerpointRgTy;

enum PowerpointMedT {
	PowerpointMedTMediaTypeUnset = '\000\333\377\376',
	PowerpointMedTMediaTypeOther = '\000\334\000\001',
	PowerpointMedTMediaTypeSound = '\000\334\000\002',
	PowerpointMedTMediaTypeMovie = '\000\334\000\003'
};
typedef enum PowerpointMedT PowerpointMedT;

enum PowerpointPSFy {
	PowerpointPSFySoundFormatUnset = '\000\367\377\376',
	PowerpointPSFySoundFormatNone = '\000\370\000\000',
	PowerpointPSFySoundFormatWAV = '\000\370\000\001',
	PowerpointPSFySoundFormatMIDI = '\000\370\000\002'
};
typedef enum PowerpointPSFy PowerpointPSFy;

enum PowerpointPeBl {
	PowerpointPeBlEastAsianLineBreakNormal = '\000\354\000\001',
	PowerpointPeBlEastAsianLineBreakStrict = '\000\354\000\002',
	PowerpointPeBlEastAsianLineBreakCustom = '\000\354\000\003'
};
typedef enum PowerpointPeBl PowerpointPeBl;

enum PowerpointSRgT {
	PowerpointSRgTSlideShowRangeShowAll = '\000\326\000\001',
	PowerpointSRgTSlideShowRange = '\000\326\000\002',
	PowerpointSRgTSlideShowRangeNamedSlideshow = '\000\326\000\003'
};
typedef enum PowerpointSRgT PowerpointSRgT;

enum PowerpointFClr {
	PowerpointFClrFrameColorsBrowserColors = '\000\317\000\001',
	PowerpointFClrFrameColorsPresentationSchemeTextColor = '\000\317\000\002',
	PowerpointFClrFrameColorsPresentationSchemeAccentColor = '\000\317\000\003',
	PowerpointFClrFrameColorsWhiteTextOnBlack = '\000\317\000\004',
	PowerpointFClrFrameColorsBlackTextOnWhite = '\000\317\000\005'
};
typedef enum PowerpointFClr PowerpointFClr;

enum PowerpointPMOt {
	PowerpointPMOtMovieOptimizationNormal = '\000\317\377\376',
	PowerpointPMOtMovieOptimizationSize = '\000\320\000\001',
	PowerpointPMOtMovieOptimizationSpeed = '\000\320\000\002',
	PowerpointPMOtMovieOptimizationQuality = '\000\320\000\003'
};
typedef enum PowerpointPMOt PowerpointPMOt;

enum PowerpointPShF {
	PowerpointPShFShapeFormatGIF = '\000\335\000\000',
	PowerpointPShFShapeFormatJPEG = '\000\335\000\001',
	PowerpointPShFShapeFormatPNG = '\000\335\000\002',
	PowerpointPShFShapeFormatPICT = '\000\335\000\003'
};
typedef enum PowerpointPShF PowerpointPShF;

enum PowerpointPBrT {
	PowerpointPBrTTopBorder = '\001\032\000\001',
	PowerpointPBrTLeftBorder = '\001\032\000\002',
	PowerpointPBrTBottomBorder = '\001\032\000\003',
	PowerpointPBrTRightBorder = '\001\032\000\004',
	PowerpointPBrTDiagonalDownBorder = '\001\032\000\005',
	PowerpointPBrTDiagonalUpBorder = '\001\032\000\006'
};
typedef enum PowerpointPBrT PowerpointPBrT;

enum PowerpointPALO {
	PowerpointPALOPageLayoutNormal = '\000\355\000\000',
	PowerpointPALOPageLayoutFullScreen = '\000\355\000\001'
};
typedef enum PowerpointPALO PowerpointPALO;

enum PowerpointPBuT {
	PowerpointPBuTRegular = '\000\356\000\001',
	PowerpointPBuTFancy = '\000\356\000\002',
	PowerpointPBuTTextOnly = '\000\356\000\003'
};
typedef enum PowerpointPBuT PowerpointPBuT;

enum PowerpointPNBp {
	PowerpointPNBpBarPlacementTop = '\000\357\000\001',
	PowerpointPNBpBarPlacementBottom = '\000\357\000\002'
};
typedef enum PowerpointPNBp PowerpointPNBp;

enum PowerpointAnFX {
	PowerpointAnFXAnimationTypeCustom = '\001\002\000\000',
	PowerpointAnFXAnimationTypeAppear = '\001\002\000\001',
	PowerpointAnFXAnimationTypeFly = '\001\002\000\002',
	PowerpointAnFXAnimationTypeBlinds = '\001\002\000\003',
	PowerpointAnFXAnimationTypeBox = '\001\002\000\004',
	PowerpointAnFXAnimationTypeCheckerboard = '\001\002\000\005',
	PowerpointAnFXAnimationTypeCircle = '\001\002\000\006',
	PowerpointAnFXAnimationTypeCrawl = '\001\002\000\007',
	PowerpointAnFXAnimationTypeDiamond = '\001\002\000\010',
	PowerpointAnFXAnimationTypeDissolve = '\001\002\000\011',
	PowerpointAnFXAnimationTypeFade = '\001\002\000\012',
	PowerpointAnFXAnimationTypeFlashOnce = '\001\002\000\013',
	PowerpointAnFXAnimationTypePeek = '\001\002\000\014',
	PowerpointAnFXAnimationTypePlus = '\001\002\000\015',
	PowerpointAnFXAnimationTypeRandomBars = '\001\002\000\016',
	PowerpointAnFXAnimationTypeSpiral = '\001\002\000\017',
	PowerpointAnFXAnimationTypeSplit = '\001\002\000\020',
	PowerpointAnFXAnimationTypeStretch = '\001\002\000\021',
	PowerpointAnFXAnimationTypeStrips = '\001\002\000\022',
	PowerpointAnFXAnimationTypeSwivel = '\001\002\000\023',
	PowerpointAnFXAnimationTypeWedge = '\001\002\000\024',
	PowerpointAnFXAnimationTypeWheel = '\001\002\000\025',
	PowerpointAnFXAnimationTypeWipe = '\001\002\000\026',
	PowerpointAnFXAnimationTypeZoom = '\001\002\000\027',
	PowerpointAnFXAnimationTypeRandomEffect = '\001\002\000\030',
	PowerpointAnFXAnimationTypeBoomerang = '\001\002\000\031',
	PowerpointAnFXAnimationTypeBounce = '\001\002\000\032',
	PowerpointAnFXAnimationTypeColorReveal = '\001\002\000\033',
	PowerpointAnFXAnimationTypeCredits = '\001\002\000\034',
	PowerpointAnFXAnimationTypeEaseIn = '\001\002\000\035',
	PowerpointAnFXAnimationTypeFloat = '\001\002\000\036',
	PowerpointAnFXAnimationTypeGrowAndTurn = '\001\002\000\037',
	PowerpointAnFXAnimationTypeLightSpeed = '\001\002\000 ',
	PowerpointAnFXAnimationTypePinwheel = '\001\002\000!',
	PowerpointAnFXAnimationTypeRiseUp = '\001\002\000\"',
	PowerpointAnFXAnimationTypeSwish = '\001\002\000#',
	PowerpointAnFXAnimationTypeThinLine = '\001\002\000$',
	PowerpointAnFXAnimationTypeUnfold = '\001\002\000%',
	PowerpointAnFXAnimationTypeWhip = '\001\002\000&',
	PowerpointAnFXAnimationTypeAscend = '\001\002\000\'',
	PowerpointAnFXAnimationTypeCenterRevolve = '\001\002\000(',
	PowerpointAnFXAnimationTypeFadedSwivel = '\001\002\000)',
	PowerpointAnFXAnimationTypeDescend = '\001\002\000*',
	PowerpointAnFXAnimationTypeSling = '\001\002\000+',
	PowerpointAnFXAnimationTypeSpinner = '\001\002\000,',
	PowerpointAnFXAnimationTypeStretchy = '\001\002\000-',
	PowerpointAnFXAnimationTypeZip = '\001\002\000.',
	PowerpointAnFXAnimationTypeArcUp = '\001\002\000/',
	PowerpointAnFXAnimationTypeFadeZoom = '\001\002\0000',
	PowerpointAnFXAnimationTypeGlide = '\001\002\0001',
	PowerpointAnFXAnimationTypeExpand = '\001\002\0002',
	PowerpointAnFXAnimationTypeFlip = '\001\002\0003',
	PowerpointAnFXAnimationTypeShimmer = '\001\002\0004',
	PowerpointAnFXAnimationTypeFold = '\001\002\0005',
	PowerpointAnFXAnimationTypeChangeFillColor = '\001\002\0006',
	PowerpointAnFXAnimationTypeChangeFont = '\001\002\0007',
	PowerpointAnFXAnimationTypeChangeFontColor = '\001\002\0008',
	PowerpointAnFXAnimationTypeChangeFontSize = '\001\002\0009',
	PowerpointAnFXAnimationTypeChangeFontStyle = '\001\002\000:',
	PowerpointAnFXAnimationTypeGrowShrink = '\001\002\000;',
	PowerpointAnFXAnimationTypeChangeLineColor = '\001\002\000<',
	PowerpointAnFXAnimationTypeSpin = '\001\002\000=',
	PowerpointAnFXAnimationTypeTransparency = '\001\002\000>',
	PowerpointAnFXAnimationTypeBoldFlash = '\001\002\000\?',
	PowerpointAnFXAnimationTypeBlast = '\001\002\000@',
	PowerpointAnFXAnimationTypeBoldReveal = '\001\002\000A',
	PowerpointAnFXAnimationTypeBrushOnColor = '\001\002\000B',
	PowerpointAnFXAnimationTypeBrushOnUnderline = '\001\002\000C',
	PowerpointAnFXAnimationTypeColorBlend = '\001\002\000D',
	PowerpointAnFXAnimationTypeColorWave = '\001\002\000E',
	PowerpointAnFXAnimationTypeComplementaryColor = '\001\002\000F',
	PowerpointAnFXAnimationTypeComplementaryColor2 = '\001\002\000G',
	PowerpointAnFXAnimationTypeConstrastingColor = '\001\002\000H',
	PowerpointAnFXAnimationTypeDarken = '\001\002\000I',
	PowerpointAnFXAnimationTypeDesaturate = '\001\002\000J',
	PowerpointAnFXAnimationTypeFlashBulb = '\001\002\000K',
	PowerpointAnFXAnimationTypeFlicker = '\001\002\000L',
	PowerpointAnFXAnimationTypeGrowWithColor = '\001\002\000M',
	PowerpointAnFXAnimationTypeLighten = '\001\002\000N',
	PowerpointAnFXAnimationTypeStyleEmphasis = '\001\002\000O',
	PowerpointAnFXAnimationTypeTeeter = '\001\002\000P',
	PowerpointAnFXAnimationTypeVerticalGrow = '\001\002\000Q',
	PowerpointAnFXAnimationTypeWave = '\001\002\000R',
	PowerpointAnFXAnimationTypeMediaPlay = '\001\002\000S',
	PowerpointAnFXAnimationTypeMediaPause = '\001\002\000T',
	PowerpointAnFXAnimationTypeMediaStop = '\001\002\000U',
	PowerpointAnFXAnimationTypeCirclePath = '\001\002\000V',
	PowerpointAnFXAnimationTypeRightTrianglePath = '\001\002\000W',
	PowerpointAnFXAnimationTypeDiamondPath = '\001\002\000X',
	PowerpointAnFXAnimationTypeHexagonPath = '\001\002\000Y',
	PowerpointAnFXAnimationType5PointStarPath = '\001\002\000Z',
	PowerpointAnFXAnimationTypeCrescentMoonPath = '\001\002\000[',
	PowerpointAnFXAnimationTypeSquarePath = '\001\002\000\\',
	PowerpointAnFXAnimationTypeTrapezoidPath = '\001\002\000]',
	PowerpointAnFXAnimationTypeHeartPath = '\001\002\000^',
	PowerpointAnFXAnimationTypeOctagonPath = '\001\002\000_',
	PowerpointAnFXAnimationType6PointStarPath = '\001\002\000`',
	PowerpointAnFXAnimationTypeFootballPath = '\001\002\000a',
	PowerpointAnFXAnimationTypeEqualTrianglePath = '\001\002\000b',
	PowerpointAnFXAnimationTypeParallelogramPath = '\001\002\000c',
	PowerpointAnFXAnimationTypePentagonPath = '\001\002\000d',
	PowerpointAnFXAnimationType4PointStarPath = '\001\002\000e',
	PowerpointAnFXAnimationType8PointStarPath = '\001\002\000f',
	PowerpointAnFXAnimationTypeTeardropPath = '\001\002\000g',
	PowerpointAnFXAnimationTypePointyStarPath = '\001\002\000h',
	PowerpointAnFXAnimationTypeCurvedSquarePath = '\001\002\000i',
	PowerpointAnFXAnimationTypeCurvedXPath = '\001\002\000j',
	PowerpointAnFXAnimationTypeVerticalFigure8Path = '\001\002\000k',
	PowerpointAnFXAnimationTypeCurvyStarPath = '\001\002\000l',
	PowerpointAnFXAnimationTypeLoopDeLoopPath = '\001\002\000m',
	PowerpointAnFXAnimationTypeBuzzsawPath = '\001\002\000n',
	PowerpointAnFXAnimationTypeHorizontalFigure8Path = '\001\002\000o',
	PowerpointAnFXAnimationTypePeanutPath = '\001\002\000p',
	PowerpointAnFXAnimationTypeFigure8FourPath = '\001\002\000q',
	PowerpointAnFXAnimationTypeNeutronPath = '\001\002\000r',
	PowerpointAnFXAnimationTypeSwooshPath = '\001\002\000s',
	PowerpointAnFXAnimationTypeBeanPath = '\001\002\000t',
	PowerpointAnFXAnimationTypePlusPath = '\001\002\000u',
	PowerpointAnFXAnimationTypeInvertedTrianglePath = '\001\002\000v',
	PowerpointAnFXAnimationTypeInvertedSquarePath = '\001\002\000w',
	PowerpointAnFXAnimationTypeLeftPath = '\001\002\000x',
	PowerpointAnFXAnimationTypeTurnRightPath = '\001\002\000y',
	PowerpointAnFXAnimationTypeArcDownPath = '\001\002\000z',
	PowerpointAnFXAnimationTypeZigzagPath = '\001\002\000{',
	PowerpointAnFXAnimationTypeSCurve2Path = '\001\002\000|',
	PowerpointAnFXAnimationTypeSineWavePath = '\001\002\000}',
	PowerpointAnFXAnimationTypeBounceLeftPath = '\001\002\000~',
	PowerpointAnFXAnimationTypeDownPath = '\001\002\000\177',
	PowerpointAnFXAnimationTypeTurnUpPath = '\001\002\000\200',
	PowerpointAnFXAnimationTypeArcUpPath = '\001\002\000\201',
	PowerpointAnFXAnimationTypeHeartbeatPath = '\001\002\000\202',
	PowerpointAnFXAnimationTypeSpiralRightPath = '\001\002\000\203',
	PowerpointAnFXAnimationTypeWavePath = '\001\002\000\204',
	PowerpointAnFXAnimationTypeCurvyLeftPath = '\001\002\000\205',
	PowerpointAnFXAnimationTypeDiagonalDownRightPath = '\001\002\000\206',
	PowerpointAnFXAnimationTypeTurnDownPath = '\001\002\000\207',
	PowerpointAnFXAnimationTypeArcLeftPath = '\001\002\000\210',
	PowerpointAnFXAnimationTypeFunnelPath = '\001\002\000\211',
	PowerpointAnFXAnimationTypeSpringPath = '\001\002\000\212',
	PowerpointAnFXAnimationTypeBounceRightPath = '\001\002\000\213',
	PowerpointAnFXAnimationTypeSpiralLeftPath = '\001\002\000\214',
	PowerpointAnFXAnimationTypeDiagonalUpRightPath = '\001\002\000\215',
	PowerpointAnFXAnimationTypeTurnUpRightPath = '\001\002\000\216',
	PowerpointAnFXAnimationTypeArcRightPath = '\001\002\000\217',
	PowerpointAnFXAnimationTypeSCurve1Path = '\001\002\000\220',
	PowerpointAnFXAnimationTypeDecayingWavePath = '\001\002\000\221',
	PowerpointAnFXAnimationTypeCurvyRightPath = '\001\002\000\222',
	PowerpointAnFXAnimationTypeStairsDownPath = '\001\002\000\223',
	PowerpointAnFXAnimationTypeUpPath = '\001\002\000\224',
	PowerpointAnFXAnimationTypeRightPath = '\001\002\000\225'
};
typedef enum PowerpointAnFX PowerpointAnFX;

enum PowerpointAnLv {
	PowerpointAnLvTextByNoLevels = '\001\001\000\000',
	PowerpointAnLvTextByAllLevels = '\001\001\000\001',
	PowerpointAnLvTextByFirstLevel = '\001\001\000\002',
	PowerpointAnLvTextBySecondLevel = '\001\001\000\003',
	PowerpointAnLvTextByThirdLevel = '\001\001\000\004',
	PowerpointAnLvTextByFourthLevel = '\001\001\000\005',
	PowerpointAnLvTextByFifthLevel = '\001\001\000\006',
	PowerpointAnLvChartAllAtOnce = '\001\001\000\007',
	PowerpointAnLvChartByCategory = '\001\001\000\010',
	PowerpointAnLvChartByCtageoryElements = '\001\001\000\011',
	PowerpointAnLvChartBySeries = '\001\001\000\012',
	PowerpointAnLvChartBySeriesElements = '\001\001\000\013'
};
typedef enum PowerpointAnLv PowerpointAnLv;

enum PowerpointAnTr {
	PowerpointAnTrNoTrigger = '\001\000\000\000',
	PowerpointAnTrOnPageClick = '\001\000\000\001',
	PowerpointAnTrWithPrevious = '\001\000\000\002',
	PowerpointAnTrAfterPrevious = '\001\000\000\003',
	PowerpointAnTrOnShapeClick = '\001\000\000\004'
};
typedef enum PowerpointAnTr PowerpointAnTr;

enum PowerpointAnAE {
	PowerpointAnAENoAfterEffect = '\000\377\000\000',
	PowerpointAnAEDim = '\000\377\000\001',
	PowerpointAnAEHide = '\000\377\000\002',
	PowerpointAnAEHideOnNextClick = '\000\377\000\003'
};
typedef enum PowerpointAnAE PowerpointAnAE;

enum PowerpointAnTU {
	PowerpointAnTUByParagraph = '\000\376\000\000',
	PowerpointAnTUByCharacter = '\000\376\000\001',
	PowerpointAnTUByWord = '\000\376\000\002'
};
typedef enum PowerpointAnTU PowerpointAnTU;

enum PowerpointAnRs {
	PowerpointAnRsRestartAlways = '\000\375\000\001',
	PowerpointAnRsRestartWhenOff = '\000\375\000\002',
	PowerpointAnRsNeverRestart = '\000\375\000\003'
};
typedef enum PowerpointAnRs PowerpointAnRs;

enum PowerpointAnEA {
	PowerpointAnEAAfterFreeze = '\000\374\000\001',
	PowerpointAnEAAfterRemove = '\000\374\000\002',
	PowerpointAnEAAfterHold = '\000\374\000\003',
	PowerpointAnEAAfterTransition = '\000\374\000\004'
};
typedef enum PowerpointAnEA PowerpointAnEA;

enum PowerpointAnDi {
	PowerpointAnDiNoDirection = '\000\371\000\000',
	PowerpointAnDiUp = '\000\371\000\001',
	PowerpointAnDiRight = '\000\371\000\002',
	PowerpointAnDiDown = '\000\371\000\003',
	PowerpointAnDiLeft = '\000\371\000\004',
	PowerpointAnDiOrdinalMask = '\000\371\000\005',
	PowerpointAnDiUpLeft = '\000\371\000\006',
	PowerpointAnDiUpRight = '\000\371\000\007',
	PowerpointAnDiDownRight = '\000\371\000\010',
	PowerpointAnDiDownLeft = '\000\371\000\011',
	PowerpointAnDiTop = '\000\371\000\012',
	PowerpointAnDiBottom = '\000\371\000\013',
	PowerpointAnDiTopLeft = '\000\371\000\014',
	PowerpointAnDiTopRight = '\000\371\000\015',
	PowerpointAnDiBottomRight = '\000\371\000\016',
	PowerpointAnDiBottomLeft = '\000\371\000\017',
	PowerpointAnDiHorizontal = '\000\371\000\020',
	PowerpointAnDiVertical = '\000\371\000\021',
	PowerpointAnDiAcross = '\000\371\000\022',
	PowerpointAnDiInward = '\000\371\000\023',
	PowerpointAnDiOut = '\000\371\000\024',
	PowerpointAnDiClockwise = '\000\371\000\025',
	PowerpointAnDiCounterclockwise = '\000\371\000\026',
	PowerpointAnDiHorizontalIn = '\000\371\000\027',
	PowerpointAnDiHorizontalOut = '\000\371\000\030',
	PowerpointAnDiVerticalIn = '\000\371\000\031',
	PowerpointAnDiVerticalOut = '\000\371\000\032',
	PowerpointAnDiSlightly = '\000\371\000\033',
	PowerpointAnDiCenter = '\000\371\000\034',
	PowerpointAnDiInSlightly = '\000\371\000\035',
	PowerpointAnDiInCenter = '\000\371\000\036',
	PowerpointAnDiInBottom = '\000\371\000\037',
	PowerpointAnDiOutSlightly = '\000\371\000 ',
	PowerpointAnDiOutCenter = '\000\371\000!',
	PowerpointAnDiOutBottom = '\000\371\000\"',
	PowerpointAnDiFontBold = '\000\371\000#',
	PowerpointAnDiFontItalic = '\000\371\000$',
	PowerpointAnDiFontUnderline = '\000\371\000%',
	PowerpointAnDiFontStrikethrough = '\000\371\000&',
	PowerpointAnDiFontShadow = '\000\371\000\'',
	PowerpointAnDiFontAllCaps = '\000\371\000(',
	PowerpointAnDiInstant = '\000\371\000)',
	PowerpointAnDiGradual = '\000\371\000*',
	PowerpointAnDiCycleClockwise = '\000\371\000+',
	PowerpointAnDiCycleCounterclockwise = '\000\371\000,'
};
typedef enum PowerpointAnDi PowerpointAnDi;

enum PowerpointAnTy {
	PowerpointAnTyAnimationTypeNone = '\001\003\000\000',
	PowerpointAnTyAnimationTypeMotion = '\001\003\000\001',
	PowerpointAnTyAnimationTypeColor = '\001\003\000\002',
	PowerpointAnTyAnimationTypeScale = '\001\003\000\003',
	PowerpointAnTyAnimationTypeRotation = '\001\003\000\004',
	PowerpointAnTyAnimationTypeProperty = '\001\003\000\005',
	PowerpointAnTyAnimationTypeCommand = '\001\003\000\006',
	PowerpointAnTyAnimationTypeFilter = '\001\003\000\007',
	PowerpointAnTyAnimationTypeSet = '\001\003\000\010'
};
typedef enum PowerpointAnTy PowerpointAnTy;

enum PowerpointAnpp {
	PowerpointAnppNoAdditive = '\001\007\000\001',
	PowerpointAnppMotion = '\001\007\000\002'
};
typedef enum PowerpointAnpp PowerpointAnpp;

enum PowerpointAnSm {
	PowerpointAnSmNoAccumulate = '\001\004\000\001',
	PowerpointAnSmAlways = '\001\004\000\002'
};
typedef enum PowerpointAnSm PowerpointAnSm;

enum PowerpointAnPr {
	PowerpointAnPrNoProperty = '\001\005\000\000',
	PowerpointAnPrX = '\001\005\000\001',
	PowerpointAnPrY = '\001\005\000\002',
	PowerpointAnPrWidth = '\001\005\000\003',
	PowerpointAnPrHeight = '\001\005\000\004',
	PowerpointAnPrOpacity = '\001\005\000\005',
	PowerpointAnPrRotation = '\001\005\000\006',
	PowerpointAnPrColors = '\001\005\000\007',
	PowerpointAnPrVisibility = '\001\005\000\010',
	PowerpointAnPrTextFontBold = '\001\005\000d',
	PowerpointAnPrTextFontColor = '\001\005\000e',
	PowerpointAnPrTextFontEmboss = '\001\005\000f',
	PowerpointAnPrTextFontItalic = '\001\005\000g',
	PowerpointAnPrTextFontName = '\001\005\000h',
	PowerpointAnPrTextFontShadow = '\001\005\000i',
	PowerpointAnPrTextFontSize = '\001\005\000j',
	PowerpointAnPrTextFontSubscript = '\001\005\000k',
	PowerpointAnPrTextFontSuperscript = '\001\005\000l',
	PowerpointAnPrTextFontUnderline = '\001\005\000m',
	PowerpointAnPrTextFontStrikethrough = '\001\005\000n',
	PowerpointAnPrTextBulletCharacter = '\001\005\000o',
	PowerpointAnPrTextBulletFontName = '\001\005\000p',
	PowerpointAnPrTextBulletNumber = '\001\005\000q',
	PowerpointAnPrTextBulletColor = '\001\005\000r',
	PowerpointAnPrTextBulletRelativeSize = '\001\005\000s',
	PowerpointAnPrTextBulletStyle = '\001\005\000t',
	PowerpointAnPrTextBulletType = '\001\005\000u',
	PowerpointAnPrShapePictureContrast = '\001\005\003\350',
	PowerpointAnPrShapePictureBrightness = '\001\005\003\351',
	PowerpointAnPrShapePictureGamma = '\001\005\003\352',
	PowerpointAnPrShapePictureGrayscale = '\001\005\003\353',
	PowerpointAnPrShapeFillOn = '\001\005\003\354',
	PowerpointAnPrShapeFillColor = '\001\005\003\355',
	PowerpointAnPrShapeFillOpacity = '\001\005\003\356',
	PowerpointAnPrShapeFillBackColor = '\001\005\003\357',
	PowerpointAnPrShapeLineOn = '\001\005\003\360',
	PowerpointAnPrShapeLineColor = '\001\005\003\361',
	PowerpointAnPrShapeShadowOn = '\001\005\003\362',
	PowerpointAnPrShapeShadowType = '\001\005\003\363',
	PowerpointAnPrShapeShadowColor = '\001\005\003\364',
	PowerpointAnPrShapeShadowOpacity = '\001\005\003\365',
	PowerpointAnPrShapeShadowOffsetX = '\001\005\003\366',
	PowerpointAnPrShapeShadowOffsetY = '\001\005\003\367'
};
typedef enum PowerpointAnPr PowerpointAnPr;

enum PowerpointAnCT {
	PowerpointAnCTEvent = '\001\006\000\000',
	PowerpointAnCTCall = '\001\006\000\001',
	PowerpointAnCTVerb = '\001\006\000\002'
};
typedef enum PowerpointAnCT PowerpointAnCT;

enum PowerpointAfet {
	PowerpointAfetNoFilterEffectType = '\001\010\000\000',
	PowerpointAfetFilterEffectTypeBarn = '\001\010\000\001',
	PowerpointAfetFilterEffectTypeBlinds = '\001\010\000\002',
	PowerpointAfetFilterEffectTypeBox = '\001\010\000\003',
	PowerpointAfetFilterEffectTypeCheckerboard = '\001\010\000\004',
	PowerpointAfetFilterEffectTypeCircle = '\001\010\000\005',
	PowerpointAfetFilterEffectTypeDiamond = '\001\010\000\006',
	PowerpointAfetFilterEffectTypeDissolve = '\001\010\000\007',
	PowerpointAfetFilterEffectTypeFade = '\001\010\000\010',
	PowerpointAfetFilterEffectTypeImage = '\001\010\000\011',
	PowerpointAfetFilterEffectTypePixelate = '\001\010\000\012',
	PowerpointAfetFilterEffectTypePlus = '\001\010\000\013',
	PowerpointAfetFilterEffectTypeRandomBar = '\001\010\000\014',
	PowerpointAfetFilterEffectTypeSlide = '\001\010\000\015',
	PowerpointAfetFilterEffectTypeStretch = '\001\010\000\016',
	PowerpointAfetFilterEffectTypeStrips = '\001\010\000\017',
	PowerpointAfetFilterEffectTypeWedge = '\001\010\000\020',
	PowerpointAfetFilterEffectTypeWheel = '\001\010\000\021',
	PowerpointAfetFilterEffectTypeWipe = '\001\010\000\022'
};
typedef enum PowerpointAfet PowerpointAfet;

enum PowerpointAfes {
	PowerpointAfesNoEffectSubtype = '\001\011\000\000',
	PowerpointAfesFilterEffectSubtypeInVertical = '\001\011\000\001',
	PowerpointAfesFilterEffectSubtypeOutVertical = '\001\011\000\002',
	PowerpointAfesFilterEffectSubtypeInHorizontal = '\001\011\000\003',
	PowerpointAfesFilterEffectSubtypeOutHorizontal = '\001\011\000\004',
	PowerpointAfesFilterEffectSubtypeHorizontal = '\001\011\000\005',
	PowerpointAfesFilterEffectSubtypeVertical = '\001\011\000\006',
	PowerpointAfesFilterEffectSubtypeInward = '\001\011\000\007',
	PowerpointAfesFilterEffectSubtypeOut = '\001\011\000\010',
	PowerpointAfesFilterEffectSubtypeAcross = '\001\011\000\011',
	PowerpointAfesFilterEffectSubtypeFromLeft = '\001\011\000\012',
	PowerpointAfesFilterEffectSubtypeFromRight = '\001\011\000\013',
	PowerpointAfesFilterEffectSubtypeFromTop = '\001\011\000\014',
	PowerpointAfesFilterEffectSubtypeFromBottom = '\001\011\000\015',
	PowerpointAfesFilterEffectSubtypeDownLeft = '\001\011\000\016',
	PowerpointAfesFilterEffectSubtypeUpLeft = '\001\011\000\017',
	PowerpointAfesFilterEffectSubtypeDownRight = '\001\011\000\020',
	PowerpointAfesFilterEffectSubtypeUpRight = '\001\011\000\021',
	PowerpointAfesFilterEffectSubtypeSpoke1 = '\001\011\000\022',
	PowerpointAfesFilterEffectSubtypeSpokes2 = '\001\011\000\023',
	PowerpointAfesFilterEffectSubtypeSpokes3 = '\001\011\000\024',
	PowerpointAfesFilterEffectSubtypeSpokes4 = '\001\011\000\025',
	PowerpointAfesFilterEffectSubtypeSpokes8 = '\001\011\000\026',
	PowerpointAfesFilterEffectSubtypeLeft = '\001\011\000\027',
	PowerpointAfesFilterEffectSubtypeRight = '\001\011\000\030',
	PowerpointAfesFilterEffectSubtypeDown = '\001\011\000\031',
	PowerpointAfesFilterEffectSubtypeUp = '\001\011\000\032'
};
typedef enum PowerpointAfes PowerpointAfes;

enum Powerpoint4002 {
	Powerpoint4002View = 'pVEW',
	Powerpoint4002Presentation = 'pptP'
};
typedef enum Powerpoint4002 Powerpoint4002;

enum Powerpoint4001 {
	Powerpoint4001Slide = 'pSLD',
	Powerpoint4001Master = 'pMtr',
	Powerpoint4001Presentation = 'pptP'
};
typedef enum Powerpoint4001 Powerpoint4001;

enum Powerpoint4003 {
	Powerpoint4003Shape = 'pShp',
	Powerpoint4003FillFormat = 'pFFm'
};
typedef enum Powerpoint4003 Powerpoint4003;

enum Powerpoint4008 {
	Powerpoint4008Shape = 'pShp',
	Powerpoint4008FillFormat = 'pFFm'
};
typedef enum Powerpoint4008 Powerpoint4008;

enum Powerpoint4016 {
	Powerpoint4016Callout = 'cD00',
	Powerpoint4016CalloutFormat = 'cCoF'
};
typedef enum Powerpoint4016 Powerpoint4016;

enum Powerpoint4011 {
	Powerpoint4011Connector = 'cD01',
	Powerpoint4011ConnectorFormat = 'pCxF'
};
typedef enum Powerpoint4011 Powerpoint4011;

enum Powerpoint4012 {
	Powerpoint4012Connector = 'cD01',
	Powerpoint4012ConnectorFormat = 'pCxF'
};
typedef enum Powerpoint4012 Powerpoint4012;

enum Powerpoint4018 {
	Powerpoint4018Callout = 'cD00',
	Powerpoint4018CalloutFormat = 'cCoF'
};
typedef enum Powerpoint4018 Powerpoint4018;

enum Powerpoint4017 {
	Powerpoint4017Callout = 'cD00',
	Powerpoint4017CalloutFormat = 'cCoF'
};
typedef enum Powerpoint4017 Powerpoint4017;

enum Powerpoint4013 {
	Powerpoint4013Connector = 'cD01',
	Powerpoint4013ConnectorFormat = 'pCxF'
};
typedef enum Powerpoint4013 Powerpoint4013;

enum Powerpoint4014 {
	Powerpoint4014Connector = 'cD01',
	Powerpoint4014ConnectorFormat = 'pCxF'
};
typedef enum Powerpoint4014 Powerpoint4014;

enum Powerpoint4004 {
	Powerpoint4004Shape = 'pShp',
	Powerpoint4004FillFormat = 'pFFm'
};
typedef enum Powerpoint4004 Powerpoint4004;

enum Powerpoint4007 {
	Powerpoint4007Shape = 'pShp',
	Powerpoint4007FillFormat = 'pFFm'
};
typedef enum Powerpoint4007 Powerpoint4007;

enum Powerpoint4015 {
	Powerpoint4015Shape = 'pShp',
	Powerpoint4015ThreeDFormat = 'D3Df'
};
typedef enum Powerpoint4015 Powerpoint4015;

enum Powerpoint4009 {
	Powerpoint4009Shape = 'pShp',
	Powerpoint4009FillFormat = 'pFFm'
};
typedef enum Powerpoint4009 Powerpoint4009;

enum Powerpoint4010 {
	Powerpoint4010Shape = 'pShp',
	Powerpoint4010FillFormat = 'pFFm'
};
typedef enum Powerpoint4010 Powerpoint4010;

enum Powerpoint4006 {
	Powerpoint4006Shape = 'pShp',
	Powerpoint4006FillFormat = 'pFFm'
};
typedef enum Powerpoint4006 Powerpoint4006;

enum Powerpoint4005 {
	Powerpoint4005Shape = 'pShp',
	Powerpoint4005FillFormat = 'pFFm'
};
typedef enum Powerpoint4005 Powerpoint4005;



/*
 * Standard Suite
 */

// A scriptable object
@interface PowerpointBaseObject : SBObject

@property (copy) NSDictionary *properties;  // All of the object's properties

- (void) closeSaving:(PowerpointSavo)saving savingIn:(PowerpointPPfd)savingIn;  // Close an object
- (NSInteger) dataSizeAs:(NSNumber *)as;  // Return the size in bytes of an object
- (void) delete;  // Delete an element from an object
- (SBObject *) duplicateTo:(SBObject *)to;  // Duplicate object(s)
- (BOOL) exists;  // Verify if an object exists
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location
- (void) open;  // Open the specified object(s)
- (void) saveIn:(PowerpointPPfd)in_ as:(PowerpointPPff)as;  // Save an object
- (void) select;  // Make a selection
- (void) quit;
- (void) setPrinterSettingsPrinterSettings:(NSInteger)printerSettings;

@end

// A basic application program
@interface PowerpointBaseApplication : PowerpointBaseObject

@property (readonly) BOOL frontmost;  // Is this the frontmost application?
@property (copy, readonly) NSString *name;  // the name
@property (copy, readonly) NSString *version;  // the version of the application


@end

// A basic document
@interface PowerpointBaseDocument : PowerpointBaseObject

@property (readonly) BOOL modified;  // Has the document been modified since the last save?
@property (copy, readonly) NSString *name;  // the name


@end

// A basic window
@interface PowerpointBasicWindow : PowerpointBaseObject

@property NSRect bounds;  // the boundary rectangle for the window
@property (readonly) BOOL closeable;  // Does the window have a close box?
@property (readonly) BOOL titled;  // Does the window have a title bar?
@property (readonly) NSInteger entryIndex;  // the number of the window
@property (readonly) BOOL floating;  // Does the window float?
@property (readonly) BOOL modal;  // Is the window modal?
@property NSPoint position;  // upper left coordinates of the window
@property (readonly) BOOL resizable;  // Is the window resizable?
@property (readonly) BOOL zoomable;  // Is the window zoomable?
@property BOOL zoomed;  // Is the window zoomed?
@property (copy, readonly) NSString *name;  // the title of the window
@property (readonly) BOOL visible;  // Is the window visible?
@property (readonly) BOOL collapsable;  // Is the window collapasable?
@property BOOL collapsed;  // Is the window collapsed?
@property (readonly) BOOL sheet;  // Is this window a sheet window?


@end

@interface PowerpointPrintSettings : SBObject

@property (readonly) NSInteger copies;  // the number of copies of a document to be printed 
@property (readonly) BOOL collating;  // Should printed copies be collated?
@property (readonly) NSInteger startingPage;  // the first page of the document to be printed
@property (readonly) NSInteger endingPage;  // the last page of the document to be printed
@property (readonly) NSInteger pagesAcross;  // number of logical pages laid across a physical page
@property (readonly) NSInteger pagesDown;  // number of logical pages laid out down a physical page
@property (copy, readonly) NSDate *requestedPrintTime;  // the time at which the desktop printer should print the document...
@property (copy, readonly) id errorHandling;  // how errors are handled
@property (copy, readonly) NSString *faxNumber;  // for fax number
@property (copy, readonly) NSString *targetPrinter;  // the queue name of the target printer

- (void) closeSaving:(PowerpointSavo)saving savingIn:(PowerpointPPfd)savingIn;  // Close an object
- (NSInteger) dataSizeAs:(NSNumber *)as;  // Return the size in bytes of an object
- (void) delete;  // Delete an element from an object
- (SBObject *) duplicateTo:(SBObject *)to;  // Duplicate object(s)
- (BOOL) exists;  // Verify if an object exists
- (SBObject *) moveTo:(SBObject *)to;  // Move object(s) to a new location
- (void) open;  // Open the specified object(s)
- (void) saveIn:(PowerpointPPfd)in_ as:(PowerpointPPff)as;  // Save an object
- (void) select;  // Make a selection
- (void) quit;
- (void) setPrinterSettingsPrinterSettings:(NSInteger)printerSettings;

@end



/*
 * Microsoft Office Suite
 */

// A control within a command bar.
@interface PowerpointCommandBarControl : PowerpointBaseObject

@property BOOL beginGroup;  // Returns or sets if the command bar control appears at the beginning of a group of controls on the command bar.
@property (readonly) BOOL builtIn;  // Returns true if the command bar control is a built-in command bar control.
@property (readonly) PowerpointMCLT controlType;  // Returns the type of the command bar control.
@property (copy) NSString *descriptionText;  // Returns or sets the description for a command bar control.  The description is not displayed to the user, but it can be useful for documenting the behavior of a control.
@property BOOL enabled;  // Returns or sets if the command bar control is enabled.
@property (readonly) NSInteger entry_index;  // Returns the index number for this command bar control.
@property NSInteger height;  // Returns or sets the height of a command bar control.
@property NSInteger helpContextID;  // Returns or sets the help context ID number for the Help topic attached to the command bar control.
@property (copy) NSString *helpFile;  // Returns or sets the file name for the help topic attached to the command bar.  To use this property, you must also set the help context ID property.
- (NSInteger) id;  // Returns the id for a built-in command bar control.
@property (readonly) NSInteger leftPosition;  // Returns the left position of the command bar control.
@property (copy) NSString *name;  // Returns or sets the caption text for a command bar control.
@property (copy) NSString *parameter;  // Returns or sets a string that is used to execute a command.
@property NSInteger priority;  // Returns or sets the priority of a command bar control. A controls priority determines whether the control can be dropped from a docked command bar if the command bar controls can not fit in a single row.  Valid priority number are 0 through 7.
@property (copy) NSString *tag;  // Returns or sets information about the command bar control, such as data that can be used as an argument in procedures, or information that identifies the control.
@property (copy) NSString *tooltipText;  // Returns or sets the text displayed in a command bar controls tooltip.
@property (readonly) NSInteger top;  // Returns the top position of a command bar control.
@property BOOL visible;  // Returns or sets if the command bar control is visible.
@property NSInteger width;  // Returns or sets the width in pixels of the command bar control.

- (void) execute;  // Runs the procedure or built-in command assigned to the specified command bar control.

@end

// A button control within a command bar.
@interface PowerpointCommandBarButton : PowerpointCommandBarControl

@property (readonly) BOOL buttonFaceIsDefault;  // Returns if the face of a command bar button control is the original built-in face.
@property PowerpointMBns buttonState;  // Returns or set the appearance of a command bar button control.  The property is read-only for built-in command bar buttons.
@property PowerpointMBTs buttonStyle;  // Returns or sets the way a command button control is displayed.
@property NSInteger faceId;  // Returns or sets the Id number for the face of the command bar button control.


@end

// A combobox menu control within a command bar.
@interface PowerpointCommandBarCombobox : PowerpointCommandBarControl

@property PowerpointMXcb comboboxStyle;  // Returns or sets the way a command bar combobox control is displayed.
@property (copy) NSString *comboboxText;  // Returns or sets the text in the display or edit portion of the command bar combobox control.
@property NSInteger dropDownLines;  // Returns or sets the number of lines in a command bar control combobox control.  The combobox control must be a custom control.
@property NSInteger dropDownWidth;  // Returns or sets the width in pixels of the list for the specified command bar combobox control.  An error occurs if you attempt to set this property for a built-in combobox control.
@property NSInteger listIndex;

- (void) addItemToComboboxComboboxItem:(NSString *)comboboxItem entry_index:(NSInteger)entry_index;  // Add a new string to a custom combobox control.
- (void) clearCombobox;  // Clear all of the strings form a custom combobox.
- (NSString *) getComboboxItemEntry_index:(NSInteger)entry_index;  // Return the string at the given index within a combobox.
- (NSInteger) getCountOfComboboxItems;  // Return the number of strings within a combobox.
- (void) removeAnItemFromComboboxEntry_index:(NSInteger)entry_index;  // Remove a string from a custom combobox.
- (void) setComboboxItemEntry_index:(NSInteger)entry_index comboboxItem:(NSString *)comboboxItem;  // Set the string an a given index for a custom combobox.

@end

// A popup menu control within a command bar.
@interface PowerpointCommandBarPopup : PowerpointCommandBarControl

- (SBElementArray *) commandBarControls;


@end

// Toolbars used in all of the Office applications.
@interface PowerpointCommandBar : PowerpointBaseObject

- (SBElementArray *) commandBarControls;

@property PowerpointMBPS barPosition;  // Returns or sets the position of the command bar.
@property (readonly) PowerpointMBTY barType;  // Returns the type of this command bar.
@property (readonly) BOOL builtIn;  // True if the command bar is built-in.
@property (copy, readonly) NSString *context;  // Returns or sets a string that determines where a command bar will be saved.
@property (readonly) BOOL embeddable;  // Returns if the command bar can be displayed inside the document window.
@property BOOL embedded;  // Returns or sets if the command bar will be displayed inside the document window.
@property BOOL enabled;  // Returns or set if the command bar is enabled.
@property (readonly) NSInteger entry_index;  // The index of the command bar.
@property NSInteger height;  // Returns or sets the height of the command bar.
@property NSInteger leftPosition;  // Returns or sets the left position of the command bar.
@property (copy) NSString *localName;  // Returns or sets the name of the command bar in the localized language of the application.  An error is returned when trying to set the local name of a built-in command bar.
@property (copy) NSString *name;  // Returns or sets the name of the command bar.
@property (copy) NSArray *protection;  // Returns or sets the way a command bar is protected from user customization.  It accepts a list of the following items: no protection, no customize, no resize, no move, no change visible, no change dock, no vertical dock, no horizontal dock.
@property NSInteger rowIndex;  // Returns or sets the docking order of a command bar in relation to other command bars in the same docking area.  Can be an integer greater than zero.
@property NSInteger top;  // Returns or sets the top position of a command bar.
@property BOOL visible;  // Returns or sets if the command bar is visible.
@property NSInteger width;  // Returns or sets the width in pixels of the command bar.


@end

@interface PowerpointDocumentProperty : PowerpointBaseObject

@property (copy) NSNumber *documentPropertyType;  // Returns or sets the document property type.
@property (copy) NSString *linkSource;  // Returns or sets the source of a lined custom document property.
@property BOOL linkToContent;  // True if the value of the document property is lined to the content of the container document.  False if the value is static.  This only applies to custom document properties.  For built-in properties this is always false.
@property (copy) NSString *name;  // Returns or sets the name of the document property.
@property (copy) NSString *value;  // Returns or sets the value of the document property.


@end

@interface PowerpointCustomDocumentProperty : PowerpointDocumentProperty


@end

@interface PowerpointWebPageFont : PowerpointBaseObject

@property (copy) NSString *fixedWidthFont;  // Returns or sets the fixed-width font setting.
@property double fixedWidthFontSize;  // Returns or sets the fixed-width font size.  You can enter half-point sizes; if you enter other fractional point sizes, they are rounded up or down to the nearest half-point.
@property (copy) NSString *proportionalFont;  // Returns or sets the proportional font setting.
@property double proportionalFontSize;  // Returns or sets the proportional font size.  You can enter half-point sizes; if you enter other fractional point sizes, they are rounded up or down to the nearest half-point.


@end



/*
 * Microsoft PowerPoint Suite
 */

@interface PowerpointActionSetting : PowerpointBaseObject

@property PowerpointPAxT action;
@property (copy) NSString *actionSettingToRun;
@property (copy, readonly) PowerpointSoundEffect *actionSoundEffect;
@property (copy) NSString *actionVerb;
@property BOOL animateAction;
@property (copy, readonly) PowerpointHyperlink *hyperlink;
@property (copy) NSString *slideShowName;


@end

@interface PowerpointAnimationBehavior : PowerpointBaseObject

@property PowerpointAnSm accumulate;
@property PowerpointAnpp additive;
@property PowerpointAnTy animationBehaviorType;
@property (copy, readonly) PowerpointColorsEffect *colorsEffect;
@property (copy, readonly) PowerpointCommandEffect *commandEffect;
@property (copy, readonly) PowerpointFilterEffect *filterEffect;
@property (copy, readonly) PowerpointMotionEffect *motionEffect;
@property (copy, readonly) PowerpointPropertyEffect *propertyEffect;
@property (copy, readonly) PowerpointRotatingEffect *rotatingEffect;
@property (copy, readonly) PowerpointScaleEffect *scaleEffect;
@property (copy, readonly) PowerpointSetEffect *setEffect;
@property (copy, readonly) PowerpointTiming *timing;


@end

@interface PowerpointAnimationPoint : PowerpointBaseObject

@property (copy) NSString *formula;
@property double time;
@property (copy) SBObject *value;


@end

@interface PowerpointAnimationSettings : PowerpointBaseObject

@property double advanceTime;
@property PowerpointAsAe afterEffect;
@property BOOL animate;
@property BOOL animateBackground;
@property BOOL animateTextInReverse;
@property NSInteger animationOrder;
@property (copy, readonly) PowerpointPlaySettings *animationPlaySettings;
@property (copy, readonly) PowerpointSoundEffect *animationSoundEffect;
@property PowerpointPCuE chartUnitEffect;
@property (copy) NSColor *dimColor;
@property PowerpointMCoI dimColorThemeIndex;
@property PowerpointPEeF entryEffect;
@property PowerpointPTlE textLevelEffect;
@property PowerpointPTuE textUnitEffect;


@end

// An AppleScript object representing the Microsoft POWERPOINT application.
@interface PowerpointApplication : SBApplication

- (SBElementArray *) presentations;
- (SBElementArray *) documentWindows;
- (SBElementArray *) slideShowWindows;
- (SBElementArray *) commandBars;

@property (copy, readonly) NSString *Version;
@property (copy, readonly) PowerpointPresentation *activePresentation;
@property (copy, readonly) NSString *activePrinter;
@property (copy, readonly) PowerpointDocumentWindow *activeWindow;
@property (copy, readonly) PowerpointAutocorrect *autocorrectObject;  // Returns the autocorrect object
@property (copy, readonly) NSString *build;
@property (copy, readonly) NSString *caption;
@property PowerpointPSAT defaultSaveFormat;
@property (copy, readonly) PowerpointDefaultWebOptions *defaultWebOptionsObject;
@property NSInteger keyboardScript;  // Returns the current keyboard script
@property (copy, readonly) NSString *name;
@property (copy, readonly) NSString *operatingSystem;
@property (copy, readonly) NSString *path;
@property (copy, readonly) PowerpointPreferences *preferenceObject;
@property (copy, readonly) PowerpointSaveAsMovieSettings *saveAsMovieSettingsObject;
@property BOOL startUpDialog;

- (void) print:(NSArray *)x withProperties:(PowerpointPrintSettings *)withProperties;  // Print the specified object(s)
- (void) quitSaving:(PowerpointSavo)saving;  // Quit an application program
- (void) select;  // Make a selection
- (void) reset:(Powerpoint4000)x;  // Resets a built-in command bar or command bar control to its default configuration.
- (void) applyTheme:(Powerpoint4001)x fileName:(NSString *)fileName;  // Applies a theme or design template to the specified slide, master or presentation
- (void) arrangeWindows:(PowerpointPArS)x;  // Arrange Document Windows
- (void) insertTheText:(NSString *)theText at:(SBObject *)at;
- (void) pasteObject:(Powerpoint4002)x;
- (void) automaticLength:(Powerpoint4016)x;
- (void) beginConnect:(Powerpoint4011)x connectedShape:(PowerpointShape *)connectedShape connectionSite:(NSInteger)connectionSite;
- (void) beginDisconnect:(Powerpoint4012)x;
- (void) customDrop:(Powerpoint4017)x dropAmount:(double)dropAmount;
- (void) customLength:(Powerpoint4018)x length:(double)length;
- (void) endConnect:(Powerpoint4013)x connectedShape:(PowerpointShape *)connectedShape connectionSite:(NSInteger)connectionSite;
- (void) endDisconnect:(Powerpoint4014)x;
- (void) oneColorGradient:(Powerpoint4003)x style:(PowerpointMGdS)style variant:(NSInteger)variant degree:(double)degree;
- (void) patterned:(Powerpoint4004)x pattern:(PowerpointPpTy)pattern;
- (void) presetGradient:(Powerpoint4005)x style:(PowerpointMGdS)style variant:(NSInteger)variant gradientType:(PowerpointMPGb)gradientType;
- (void) presetTextured:(Powerpoint4006)x texture:(PowerpointMPzT)texture;
- (void) resetRotation:(Powerpoint4015)x;
- (void) solid:(Powerpoint4007)x;
- (void) twoColorGradient:(Powerpoint4008)x style:(PowerpointMGdS)style variant:(NSInteger)variant;
- (void) userPicture:(Powerpoint4009)x pictureFile:(NSString *)pictureFile;
- (void) userTextured:(Powerpoint4010)x textureFile:(NSString *)textureFile;

@end

// Represents a single autocorrect entry.
@interface PowerpointAutocorrectEntry : PowerpointBaseObject

@property (copy, readonly) NSString *autocorrectValue;  // Returns the value of the auto correct entry.
@property (readonly) NSInteger entry_index;  // Returns the index for the position of the object in its container element list.
@property (copy, readonly) NSString *name;  // Returns the name of the auto correct entry.


@end

// Represents the autocorrect functionality in PowerPoint.
@interface PowerpointAutocorrect : PowerpointBaseObject

- (SBElementArray *) autocorrectEntries;
- (SBElementArray *) firstLetterExceptions;
- (SBElementArray *) twoInitialCapsExceptions;

@property BOOL correctDays;  // Returns if PowerPoint automatically capitalizes the first letter of days of the week.
@property BOOL correctInitialCaps;  // Returns if PowerPoint automatically makes the second letter lowercase if the first two letters of a word are typed in uppercase. For example, POwerPoint is corrected to PowerPoint.
@property BOOL correctSentenceCaps;  // Returns if PowerPoint automatically capitalizes the first letter in each sentence.
@property BOOL replaceText;  // Returns if Microsoft PowerPoint automatically replaces specified text with entries from the autocorrect list.


@end

@interface PowerpointBulletFormat : PowerpointBaseObject

@property (copy) NSString *bulletCharacter;  // Returns or sets the Unicode character value that is used for bullets in the specified text.
@property (copy, readonly) PowerpointFont *bulletFont;  // Returns a font object that represents character formatting for a bullet format object.
@property (readonly) NSInteger bulletNumber;  // Returns the bullet number of a paragraph.
@property NSInteger bulletStartValue;
@property PowerpointPBtS bulletStyle;  // Returns or sets a constant that represents the style of a bullet.
@property PowerpointPBtT bulletType;  // Returns or sets a constant that represents the type of bullet.
@property double relativeSize;  // Returns or sets the bullet size relative to the size of the first text character in the paragraph.
@property BOOL useTextColor;  // Determines whether the specified bullets are set to the color of the first text character in the paragraph.
@property BOOL useTextFont;  // Determines whether the specified bullets are set to the font of the first text character in the paragraph.
@property BOOL visible;  // Returns or sets a value that specifies whether the bullet is visible.

- (void) setBulletPicturePictureFile:(NSString *)pictureFile;  // Sets the graphics file to be used for bullets in a bulleted list.

@end

@interface PowerpointColorScheme : PowerpointBaseObject

- (NSColor *) getColorFromAt:(PowerpointPCSi)at;
- (void) setColorForAt:(PowerpointPCSi)at toColor:(NSColor *)toColor;

@end

@interface PowerpointColorsEffect : PowerpointBaseObject

@property (copy) NSColor *by_color;
@property PowerpointMCoI by_colorThemeIndex;  // Returns an object that represents a change to the color of the object by the specified number, expressed in RGB format.
@property (copy) NSColor *from_color;
@property PowerpointMCoI from_colorThemeIndex;  // Returns or sets an object that represents the starting RGB color value of an animation behavior.
@property (copy) NSColor *to_color;
@property PowerpointMCoI to_colorThemeIndex;  // Returns or sets an object that represents the RGB color value of an animation behavior.


@end

@interface PowerpointCommandEffect : PowerpointBaseObject

@property (copy) NSString *command;
@property PowerpointAnCT type;


@end

@interface PowerpointCustomLayout : PowerpointBaseObject

- (SBElementArray *) shapes;

@property (copy, readonly) PowerpointShape *background;
@property (copy, readonly) PowerpointDesign *design;
@property BOOL displayMasterShapes;
@property BOOL followMasterBackground;
@property (copy, readonly) PowerpointHeadersAndFooters *headersAndFooters;
@property (readonly) double height;
@property (copy, readonly) PowerpointThemeColorScheme *themeColorScheme;  // Returns the color scheme of a custom layout.
@property (copy, readonly) PowerpointTimeline *timeline;
@property (readonly) double width;


@end

@interface PowerpointDefaultWebOptions : PowerpointBaseObject

@property BOOL allowPNG;
@property BOOL alwaysSaveInDefaultEncoding;
@property PowerpointPBuT buttonsType;
@property BOOL checkIfOfficeIsHTMLEditor;
@property PowerpointMtEn encoding;
@property PowerpointFClr frameColors;
@property BOOL includeBinaryFile;
@property PowerpointPNBp navBarPlacement;
@property BOOL supportIE4;
@property BOOL supportNN4;
@property BOOL supportOlderBrowsers;
@property BOOL updateLinksOnSave;
@property (copy) NSString *webPageKeywords;
@property (copy) NSString *webPageTitle;


@end

@interface PowerpointDesign : PowerpointBaseObject

@property (copy, readonly) PowerpointMaster *slideMaster;


@end

@interface PowerpointDocumentWindow : PowerpointBasicWindow

- (SBElementArray *) panes;

@property (readonly) BOOL active;
@property (copy, readonly) PowerpointPane *activePane;
@property BOOL blackAndWhite;
@property (copy, readonly) NSString *caption;
@property (readonly) NSInteger entry_index;
@property double height;
@property double leftPosition;
@property (copy, readonly) PowerpointPresentation *presentation;
@property NSInteger splitHorizontal;
@property NSInteger splitVertical;
@property double top;
@property (copy, readonly) PowerpointView *view;
@property PowerpointPVTy viewType;
@property double width;

- (void) launchSpellerOn;

@end

@interface PowerpointEffectInformation : PowerpointBaseObject

@property (readonly) PowerpointAnAE afterEffectInformation;
@property (readonly) BOOL animateBackgroundInformation;
@property (readonly) BOOL animateTextInReverseInformation;
@property (readonly) PowerpointAnLv buildByLevel;
@property (copy, readonly) NSColor *dim;
@property (copy, readonly) PowerpointPlaySettings *playSettingsInformation;
@property (copy, readonly) PowerpointSoundEffect *soundEffectInformation;
@property (readonly) PowerpointAnTU textUnitEffectInformation;


@end

@interface PowerpointEffectParameters : PowerpointBaseObject

@property double amount;
@property (copy, readonly) NSColor *color2;
@property (readonly) PowerpointMCoI color2ColorThemeIndex;  // Returns an object that represents the color on which to end a color-cycle animation.
@property PowerpointAnDi direction;
@property (copy) NSString *font2;
@property BOOL relative;
@property double size2;


@end

@interface PowerpointEffect : PowerpointBaseObject

- (SBElementArray *) animationBehaviors;

@property PowerpointAnFX animationEffectType;
@property (copy, readonly) PowerpointEffectInformation *effectInformation;
@property (copy, readonly) PowerpointEffectParameters *effectParameters;
@property BOOL exitAnimation;
@property (copy, readonly) NSString *name;
@property (copy) PowerpointShape *shape;
@property NSInteger targetParagraph;
@property (readonly) NSInteger textRangeLength;
@property (readonly) NSInteger textRangeStart;
@property (copy, readonly) PowerpointTiming *timing;

- (PowerpointAnimationBehavior *) addBehaviorType:(PowerpointAnTy)type;  // add an animation behavior

@end

@interface PowerpointFilterEffect : PowerpointBaseObject

@property PowerpointAfet filterType;
@property BOOL reveal;
@property PowerpointAfes subtype;


@end

// Represents an abbreviation excluded from automatic correction.
@interface PowerpointFirstLetterException : PowerpointBaseObject

@property (readonly) NSInteger entry_index;  // Returns the index for the position of the object in its container element list.
@property (copy, readonly) NSString *name;  // Returns the name of the FirstLetterException.


@end

// Contains font attributes, such as font name, size, and color, for an object.
@interface PowerpointFont : PowerpointBaseObject

@property (copy) NSString *ASCIIName;  // Returns or sets the font used for Latin text; characters with character codes from 0 through 127.
@property BOOL autoRotateNumbers;  // Returns or sets a value that specifies whether the numbers in a numbered list should be rotated when the text is rotated.
@property double baseLineOffset;  // Returns or sets a value specifying the horizontaol offset of the selected font.
@property BOOL bold;  // Returns or sets a value specifying whether the font should be bold.
@property PowerpointMTCa capsType;  // Returns or sets a value specifying how the text should be capitalized.
@property (copy) NSString *eastAsianName;  // Returns or sets the font name used for Asian text.
@property (readonly) BOOL embedable;  // Returns a value indicating whether the font can be embedded in a page.
@property (readonly) BOOL embedded;  // Returns a value specifying whether the font is embedded in a page.
@property BOOL emboss;
@property BOOL equalizeCharacterHeight;  // Returns or sets a value specifying whether the text should have the same horizontal height.
@property (copy, readonly) PowerpointFillFormat *fillFormat;  // Returns a value specifying the fill formatting for text.
@property (copy) NSColor *fontColor;
@property PowerpointMCoI fontColorThemeIndex;  // Returns or sets the color for the specified font.
@property (copy) NSString *fontName;  // Returns or sets a value specifying the font to use for a selection.
@property (copy) NSString *fontNameOther;  // Returns or sets the font used for characters whose character set numbers are greater than 127.
@property double fontSize;
@property (copy, readonly) PowerpointGlowFormat *glowFormat;  // Returns a value specifying the glow formatting of the text.
@property (copy) NSColor *highlightColor;  // Returns or sets the text highlight color for object.
@property PowerpointMCoI highlightColorThemeIndex;  // Returns or sets the specified text highlight color for object.
@property BOOL italic;
@property double kerning;  // Returns or sets a value specifying the amount of spacing between text characters.
@property (copy, readonly) PowerpointLineFormat *lineFormat;  // Returns a value specifiying the line formatting of the text.
@property (copy, readonly) PowerpointReflectionFormat *reflectionFormat;  // Returns a value specifying the reflection formatting of the text.
@property (copy, readonly) PowerpointShadowFormat *shadowFormat;  // Returns the value specifying the type of shadow effect for the selection of text.
@property PowerpointMSET softEdgeFormat;  // Returns or sets a value specifying the soft edge fromatting of the text.
@property double spacing;  // Returns or sets a value specifying the spacing between characters in a selection of text.
@property PowerpointMTSt strikeType;  // Returns or sets a value specifying the strike format used for a selection of text.
@property BOOL subscript;  // Returns or sets a value specifying that the selected text should be displayed a subscript.
@property BOOL superscript;  // Returns or sets a value specifying that the selected text should be displayed a superscript.
@property double transparency;
@property BOOL underline;
@property (copy) NSColor *underlineColor;  // Returns or sets the 24-bit color of the underline for the specified font object.
@property PowerpointMCoI underlineColorThemeIndex;  // Returns a value specifying the color of the underline for the selected text.
@property PowerpointMTUl underlineStyle;  // Returns or sets a value specifying the underline style for the selected text.
@property PowerpointMPXF wordArtStylesFormat;  // Returns or sets a value specifying the text effect for the selected text.


@end

@interface PowerpointHeaderOrFooter : PowerpointBaseObject

@property PowerpointPDtF dateFormat;
@property (copy) NSString *headerFooterText;
@property BOOL useDateFormat;
@property BOOL visible;


@end

@interface PowerpointHeadersAndFooters : PowerpointBaseObject

@property (copy, readonly) PowerpointHeaderOrFooter *dateAndTime;
@property BOOL displayHeadersFootersOnTitleSlide;
@property (copy, readonly) PowerpointHeaderOrFooter *footer;
@property (copy, readonly) PowerpointHeaderOrFooter *header;
@property (copy, readonly) PowerpointHeaderOrFooter *slideNumber;


@end

@interface PowerpointHyperlink : PowerpointBaseObject

@property (copy) NSString *hyperlinkAddress;
@property (copy) NSString *hyperlinkSubAddress;
@property (readonly) PowerpointMHyT hyperlinkType;


@end

@interface PowerpointMaster : PowerpointBaseObject

- (SBElementArray *) shapes;
- (SBElementArray *) hyperlinks;
- (SBElementArray *) customLayouts;

@property (copy, readonly) PowerpointShape *background;
@property (copy, readonly) PowerpointColorScheme *colorScheme;
@property (copy, readonly) PowerpointDesign *design;
@property (copy, readonly) PowerpointHeadersAndFooters *headersAndFooters;
@property (readonly) double height;
@property (copy, readonly) PowerpointOfficeTheme *theme;
@property (copy, readonly) PowerpointTimeline *timeline;
@property (readonly) double width;

- (PowerpointTextStyle *) getTextStyleFromAt:(PowerpointPTst)at;

@end

@interface PowerpointMotionEffect : PowerpointBaseObject

@property double byX;
@property double byY;
@property double fromX;
@property double fromY;
@property (copy) NSString *path;
@property double toX;
@property double toY;


@end

@interface PowerpointNamedSlideShow : PowerpointBaseObject

@property (copy, readonly) NSString *name;
@property (readonly) NSInteger numberOfSlides;
@property (copy, readonly) NSArray *slideIDs;


@end

@interface PowerpointPageSetup : PowerpointBaseObject

@property NSInteger firstSlideNumber;
@property PowerpointMOrT notesOrientation;
@property PowerpointMOrT slideOrientation;
@property PowerpointSSzT slideSize;
@property double slideWidth;


@end

@interface PowerpointPane : PowerpointBaseObject

@property (readonly) BOOL active;
@property (readonly) PowerpointPVTy paneViewType;


@end

@interface PowerpointParagraphFormat : PowerpointBaseObject

- (SBElementArray *) tabStops;

@property PowerpointPpgA alignment;
@property PowerpointPBlA baselineAlignment;  // Returns or sets a constant that represents the vertical position of fonts in a paragraph.
@property (copy, readonly) PowerpointBulletFormat *bulletFormat;
@property BOOL eastAsianLineBreakControl;
@property double firstLineIndent;  // Returns or sets the value, in points, for a first line or hanging indent.
@property BOOL hangingPunctuation;  // Determines whether hanging punctuation is enabled for the specified paragraphs.
@property NSInteger indentLevel;  // Returns or sets a value representing the indent level assigned to text in the selected paragraph.
@property double leftIndent;  // Returns or sets a value that represents the left indent value, in points, for the specified paragraphs.
@property BOOL lineRuleAfter;  // Determines whether line spacing after the last line in each paragraph is set to a specific number of points or lines.
@property BOOL lineRuleBefore;  // Determines whether line spacing before the first line in each paragraph is set to a specific number of points or lines.
@property BOOL lineRuleWithin;  // Determines whether line spacing between base lines is set to a specific number of points or lines.
@property double rightIndent;  // Returns or sets the right indent, in points, for the specified paragraphs.
@property double spaceAfter;  // Returns or sets the spacing, in points, after the specified paragraphs.
@property double spaceBefore;  // Returns or sets the spacing, in points, before the specified paragraphs.
@property double spaceWithin;  // Returns or sets the amount of space between base lines in the specified paragraph, in points or lines.
@property PowerpointPDrT textDirection;  // Returns or sets the text direction for the specified paragraph.
@property BOOL wordWrap;  // Determines whether the application wraps the Latin text in the middle of a word in the specified paragraphs.


@end

@interface PowerpointPlaySettings : PowerpointBaseObject

@property BOOL hideWhileNotPlaying;
@property BOOL loopUntilStopped;
@property BOOL pauseAnimation;
@property BOOL playOnEntry;
@property BOOL rewindMove;
@property NSInteger stopAfterSlides;


@end

@interface PowerpointPreferences : PowerpointBaseObject

@property NSInteger alwaysSuggestCorrections;
@property NSInteger appendDOSExtentions;
@property NSInteger autoFit;
@property NSInteger autoRecoveryFrequency;
@property NSInteger backgroundSpelling;
@property NSInteger compressFile;
@property NSInteger defaultView;
@property NSInteger dragDrop;
@property NSInteger endBlankSlide;
@property NSInteger filePropertiesPrompt;
@property NSInteger fullTextSearch;
@property NSInteger hideSpellingErrors;
@property NSInteger ignoreNumbersInWords;
@property NSInteger ignoreUppercase;
@property NSInteger linkSoundLimit;
@property NSInteger mruListActive;
@property NSInteger mruListSize;
@property NSInteger optionBitmap;
@property NSInteger rulerUnits;
@property NSInteger saveAutoRecovery;
@property NSInteger showVerticalRuler;
@property NSInteger slideShowControl;
@property NSInteger slideShowRightMouse;
@property NSInteger smartCutPaste;
@property NSInteger smartQuotes;
@property NSInteger undoLevelCount;
@property (copy) NSString *userInitials;
@property (copy) NSString *userName;
@property NSInteger wordSelection;


@end

@interface PowerpointPresentation : PowerpointBaseObject

- (SBElementArray *) slides;
- (SBElementArray *) colorSchemes;
- (SBElementArray *) fonts;
- (SBElementArray *) documentWindows;
- (SBElementArray *) documentProperties;
- (SBElementArray *) customDocumentProperties;
- (SBElementArray *) designs;

@property (copy, readonly) PowerpointShape *defaultShape;
@property PowerpointPeBl eastAsianLineBreakLevel;  // Returns or sets the East Asian line break control level for the specified paragraph.
@property (copy, readonly) NSString *fullName;
@property (copy, readonly) PowerpointMaster *handoutMaster;
@property (readonly) BOOL hasTitleMaster;
@property PowerpointPDrT layoutDirection;
@property (copy, readonly) NSString *name;
@property (copy) NSString *noLineBreakAfter;
@property (copy) NSString *noLineBreakBefore;
@property (copy, readonly) PowerpointMaster *notesMaster;
@property (copy, readonly) PowerpointPageSetup *pageSetup;
@property (copy, readonly) NSString *path;
@property (copy, readonly) PowerpointPrintOptions *printOptions;
@property (readonly) BOOL readOnly;
@property (copy, readonly) PowerpointSaveAsMovieSettings *saveAsMovieSettings;
@property BOOL saved;
@property (copy, readonly) PowerpointMaster *slideMaster;
@property (copy, readonly) PowerpointSlideShowSettings *slideShowSettings;
@property (copy, readonly) PowerpointSlideShowWindow *slideShowWindow;
@property (copy, readonly) NSString *templateName;
@property (copy, readonly) PowerpointMaster *titleMaster;
@property (copy, readonly) PowerpointWebOptions *webOptions;

- (PowerpointDesign *) addDesignDesignName:(NSString *)DesignName index:(NSInteger)index;  // add a new design
- (void) applyTemplateFileName:(NSString *)fileName;  // Applies a theme or design template to the specified slide, master or presentation
- (void) printOutFrom:(NSInteger)from to:(NSInteger)to printToFile:(NSString *)printToFile copies:(NSInteger)copies collate:(BOOL)collate showDialog:(BOOL)showDialog;
- (void) redoTimes:(NSInteger)times;
- (void) undoTimes:(NSInteger)times;
- (void) updateLinks;

@end

@interface PowerpointPresenterTool : PowerpointBaseObject

@property (copy, readonly) PowerpointSlide *currentPresenterSlide;
@property (copy) NSString *notesText;
@property NSInteger notesZoom;
@property (readonly) BOOL slideMiniature;

- (void) endShow;
- (void) next;
- (void) previous;
- (void) toggleSlideMiniature;

@end

@interface PowerpointPresenterViewWindow : PowerpointBasicWindow

@property (readonly) BOOL active;
@property (readonly) double height;
@property (copy, readonly) PowerpointPresentation *presentation;
@property (copy, readonly) PowerpointPresenterTool *presenterTool;
@property (readonly) double width;


@end

@interface PowerpointPrintOptions : PowerpointBaseObject

- (SBElementArray *) printRanges;

@property (copy, readonly) NSString *activePrinter;
@property BOOL collate;
@property BOOL fitToPage;
@property BOOL frameSlides;
@property NSInteger numberOfCopies;
@property PowerpointPtOt outputType;
@property PowerpointPrCt printColorType;
@property BOOL printFontsAsGraphics;
@property BOOL printHiddenSlides;
@property PowerpointRgTy rangeType;
@property (copy) NSString *slideShowName;


@end

@interface PowerpointPrintRange : PowerpointBaseObject

@property (readonly) NSInteger rangeEnd;
@property (readonly) NSInteger rangeStart;


@end

@interface PowerpointPropertyEffect : PowerpointBaseObject

- (SBElementArray *) animationPoints;

@property (copy, readonly) id ending;
@property PowerpointAnPr propertySetEffect;
@property (copy, readonly) id starting;


@end

@interface PowerpointRotatingEffect : PowerpointBaseObject

@property double rotating;


@end

@interface PowerpointRulerLevel : PowerpointBaseObject

@property double firstMargin;  // Returns or sets the first-line indent for the specified outline level, in points.
@property double leftMargin;  // Returns or sets the left indent for the specified outline level, in points.


@end

// Represents the ruler for the text in the specified shape or for all text in the specified text style. Contains tab stops and the indentation settings for text outline levels.
@interface PowerpointRuler : PowerpointBaseObject

- (SBElementArray *) tabStops;
- (SBElementArray *) rulerLevels;


@end

@interface PowerpointSaveAsMovieSettings : PowerpointBaseObject

@property BOOL autoLoopEnabled;
@property (copy) NSString *backgroundSoundTrackFile;
@property NSInteger backgroundTrackSegmentEnd;
@property NSInteger backgroundTrackSegmentStart;
@property NSInteger backgroundTrackStart;
@property BOOL createMoviePreview;
@property BOOL forceAllInline;
@property BOOL includeNarrationAndSounds;
@property (copy) NSString *movieActors;
@property (copy) NSString *movieAuthor;
@property (copy) NSString *movieCopyright;
@property NSInteger movieFrameHeight;
@property NSInteger movieFrameWidth;
@property (copy) NSString *movieProducer;
@property PowerpointPMOt optimization;
@property BOOL showMovieController;
@property (copy) NSString *transitionDescription;
@property BOOL useSingleTransition;


@end

@interface PowerpointScaleEffect : PowerpointBaseObject

@property double byX;
@property double byY;
@property double fromX;
@property double fromY;
@property double toX;
@property double toY;


@end

@interface PowerpointSequence : PowerpointBaseObject

- (SBElementArray *) effects;

- (PowerpointEffect *) addEffectFor:(PowerpointShape *)for_ fx:(PowerpointAnFX)fx level:(PowerpointAnLv)level trigger:(PowerpointAnTr)trigger index:(NSInteger)index;  // add an effect for a shape
- (PowerpointEffect *) convertToTextUnitEffectEffect:(PowerpointEffect *)Effect unit:(PowerpointAnTU)unit;  // convert an effect to a text unit effect

@end

@interface PowerpointSetEffect : PowerpointBaseObject

@property (copy) id ending;
@property PowerpointAnPr propertySetEffect;


@end

@interface PowerpointSlideShowSettings : PowerpointBaseObject

- (SBElementArray *) namedSlideShows;

@property PowerpointPSaM advanceMode;
@property NSInteger endingSlide;
@property BOOL loopUntilStopped;
@property (copy) NSColor *pointerColor;
@property PowerpointMCoI pointerColorThemeIndex;  // Returns or sets the color of  default pointer color for a presentation.
@property PowerpointSRgT rangeType;
@property PowerpointPSSt showType;
@property (readonly) BOOL showWithAnimation;
@property BOOL showWithNarration;
@property (copy) NSString *slideShowName;
@property NSInteger startingSlide;

- (PowerpointSlideShowWindow *) runSlideShow;

@end

@interface PowerpointSlideShowTransition : PowerpointBaseObject

@property BOOL advanceOnClick;
@property BOOL advanceOnTime;
@property double advanceTime;
@property PowerpointPEeF entryEffect;
@property BOOL hidden;
@property BOOL loopSoundUntilNext;
@property (copy, readonly) PowerpointSoundEffect *soundEffectTransition;


@end

@interface PowerpointSlideShowView : PowerpointBaseObject

@property BOOL accelerationsEnabled;
@property (readonly) NSInteger currentShowPosition;
@property (readonly) BOOL isNamedShow;
@property (copy, readonly) PowerpointSlide *lastSlideViewed;
@property (copy) NSColor *pointerColor;
@property PowerpointMCoI pointerColorThemeIndex;  // Returns or sets the color of temporary pointer color for a view of a slide show.
@property PowerpointPSsP pointerType;
@property (readonly) double presentationElapsedTime;
@property double slideElapsedTime;
@property (copy, readonly) NSString *slideShowName;
@property PowerpointPShS slideState;
@property (readonly) NSInteger zoom;

- (void) exitSlideShow;
- (void) goToFirstSlide;
- (void) goToLastSlide;
- (void) goToNextSlide;
- (void) goToPreviousSlide;
- (void) resetSlideTime;

@end

@interface PowerpointSlideShowWindow : PowerpointBasicWindow

@property (readonly) BOOL active;
@property NSRect bounds;
@property double height;
@property (readonly) BOOL isFullScreen;
@property double leftPosition;
@property (copy, readonly) PowerpointPresentation *presentation;
@property (copy, readonly) PowerpointSlideShowView *slideshowView;
@property double top;
@property double width;


@end

@interface PowerpointSlide : PowerpointBaseObject

- (SBElementArray *) shapes;
- (SBElementArray *) hyperlinks;

@property (copy, readonly) PowerpointShape *background;
@property (copy) PowerpointColorScheme *colorScheme;
@property (copy) PowerpointCustomLayout *customLayout;
@property (copy) PowerpointDesign *design;
@property BOOL displayMasterShapes;
@property BOOL followMasterBackground;
@property (copy, readonly) PowerpointHeadersAndFooters *headersAndFooters;
@property PowerpointPSLo layout;
@property (copy, readonly) PowerpointSlide *notesPage;
@property (readonly) NSInteger printSteps;
@property (readonly) NSInteger slideID;
@property (readonly) NSInteger slideIndex;
@property (copy, readonly) PowerpointMaster *slideMaster;
@property (readonly) NSInteger slideNumber;
@property (copy, readonly) PowerpointSlideShowTransition *slideShowTransition;
@property (copy, readonly) PowerpointTimeline *timeline;

- (void) applyThemeColorSchemeFileName:(NSString *)fileName;  // Applies a theme color to the specified slide.
- (void) copyObject;
- (void) cutObject;

@end

@interface PowerpointSoundEffect : PowerpointBaseObject

@property (copy, readonly) NSString *name;
@property PowerpointPSnX soundType;

- (void) importSoundFileSoundFileName:(NSString *)soundFileName;
- (void) playSoundEffect;

@end

// Represents a single tab stop.
@interface PowerpointTabStop : PowerpointBaseObject

@property double tabPosition;  // Returns or sets the position of a tab stop relative to the left margin.
@property PowerpointPTSp tabStopType;  // Returns or sets the type of the tab stop object.


@end

@interface PowerpointTextStyleLevel : PowerpointBaseObject

@property (copy, readonly) PowerpointFont *font;
@property (copy, readonly) PowerpointParagraphFormat *paragraphFormat;


@end

@interface PowerpointTextStyle : PowerpointBaseObject

- (SBElementArray *) textStyleLevels;

@property (copy, readonly) PowerpointRuler *ruler;
@property (copy, readonly) PowerpointTextFrame *textFrame;


@end

@interface PowerpointTimeline : PowerpointBaseObject

- (SBElementArray *) sequences;

@property (copy, readonly) PowerpointSequence *mainSequence;

- (PowerpointSequence *) addSequenceIndex:(NSInteger)index;  // add an interactive sequence

@end

@interface PowerpointTiming : PowerpointBaseObject

@property double acceleration;
@property BOOL autoreverse;
@property double deceleration;
@property double duration;
@property NSInteger repeatCount;
@property double repeatDuration;
@property PowerpointAnRs restart;
@property BOOL rewind;
@property BOOL smoothEnd;
@property BOOL smoothStart;
@property double speed;


@end

// Represents a single initial-capital autocorrect exception.
@interface PowerpointTwoInitialCapsException : PowerpointBaseObject

@property (readonly) NSInteger entry_index;  // Returns the index for the position of the object in its container element list.
@property (copy, readonly) NSString *name;  // Returns the name of the TwoInitialCapsException.


@end

@interface PowerpointView : PowerpointBaseObject

@property BOOL displaySlideMiniature;
@property (copy) PowerpointSlide *slide;
@property (readonly) PowerpointPVTy viewType;
@property NSInteger zoom;
@property BOOL zoomToFit;

- (void) goToSlideNumber:(NSInteger)number;

@end

@interface PowerpointWebOptions : PowerpointBaseObject

@property BOOL allowPNG;
@property PowerpointPBuT buttonsType;
@property PowerpointMtEn encoding;
@property PowerpointFClr frameColors;
@property BOOL includeBinaryFile;
@property PowerpointPNBp navBarPlacement;
@property PowerpointPALO pageLayout;
@property BOOL supportIE4;
@property BOOL supportNN4;
@property BOOL supportOlderBrowsers;
@property (copy) NSString *webPageKeywords;
@property (copy) NSString *webPageTitle;


@end



/*
 * Drawing Suite
 */

@interface PowerpointAdjustment : PowerpointBaseObject

@property double adjustment_value;


@end

@interface PowerpointCalloutFormat : PowerpointBaseObject

@property BOOL accent;
@property PowerpointMCAt angle;
@property BOOL autoAttach;
@property (readonly) BOOL autoLength;
@property BOOL border;
@property (readonly) double calloutFormatLength;
@property PowerpointMCot calloutType;
@property (readonly) double drop;
@property (readonly) PowerpointMCDt dropType;
@property double gap;

- (void) presetDropDropType:(PowerpointMCDt)dropType;

@end

@interface PowerpointConnectorFormat : PowerpointBaseObject

@property (readonly) BOOL beginConnected;
@property (copy, readonly) PowerpointShape *beginConnectedShape;
@property (readonly) NSInteger beginConnectionSite;
@property PowerpointMCtT connectorType;
@property (readonly) BOOL endConnected;
@property (copy, readonly) PowerpointShape *endConnectedShape;
@property (readonly) NSInteger endConnectionSite;


@end

// Represents fill formatting for a shape. A shape can have a solid, gradient, texture, pattern, picture, or semi-transparent fill.
@interface PowerpointFillFormat : PowerpointBaseObject

- (SBElementArray *) gradientStops;

@property (copy) NSColor *backColor;
@property PowerpointMCoI backColorThemeIndex;  // Returns or sets the specified fill background color.
@property (readonly) PowerpointMFdT fillFormatType;
@property (copy) NSColor *foreColor;
@property PowerpointMCoI foreColorThemeIndex;  // Returns or sets the specified foreground fill or solid color.
@property (readonly) PowerpointMGCt gradientColorType;
@property (readonly) double gradientDegree;
@property (readonly) PowerpointMGdS gradientStyle;
@property (readonly) NSInteger gradientVariant;
@property (readonly) PowerpointPpTy pattern;
@property (readonly) PowerpointMPGb presetGradientType;
@property (readonly) PowerpointMPzT presetTexture;
@property BOOL rotateWithObject;  // Returns or sets whether the fill rotates with the specified shape.
@property PowerpointMTtA textureAlignment;  // Returns or sets the texture alignment for the specified object.
@property double textureHorizontalScale;  // Returns or sets the texture alignment for the specified object.
@property (copy, readonly) NSString *textureName;
@property double textureOffsetX;  // Returns or sets the texture alignment for the specified object.
@property double textureOffsetY;  // Returns or sets the texture alignment for the specified object.
@property BOOL textureTile;  // Returns the texture tile style for the specified fill.
@property double textureVerticalScale;  // Returns or sets the texture alignment for the specified object.
@property double transparency;
@property BOOL visible;

- (void) deleteGradientStopStopIndex:(NSInteger)stopIndex;  // Removes a gradient stop.
- (void) insertGradientStopCustomColor:(NSColor *)customColor position:(double)position transparency:(double)transparency stopIndex:(NSInteger)stopIndex;  // Adds a stop to a gradient.

@end

// Represents the glow formatting for a shape or range of shapes
@interface PowerpointGlowFormat : PowerpointBaseObject

@property (copy) NSColor *color;  // Returns or sets the color for the specified glow format.
@property PowerpointMCoI colorThemeIndex;  // Returns or sets the color for the specified glow format.
@property double radius;  // Returns or sets the length of the radius for the specified glow format.


@end

// Represents one gradient stop.
@interface PowerpointGradientStop : PowerpointBaseObject

@property (copy) NSColor *color;  // Returns or sets the color for the specified the gradient stop.
@property PowerpointMCoI colorThemeIndex;  // Returns or sets the color for the specified gradient stop.
@property double position;  // Returns or sets the position for the specified gradient stop expressed as a percent.
@property double transparency;  // Returns or sets a value representing the transparency of the gradient fill expressed as a percent.


@end

@interface PowerpointLineFormat : PowerpointBaseObject

@property (copy) NSColor *backColor;
@property PowerpointMCoI backColorThemeIndex;  // Returns or sets the background color for a patterned line.
@property PowerpointMAhL beginArrowHeadLength;
@property PowerpointMAhS beginArrowheadStyle;
@property PowerpointMAhW beginArrowheadWidth;
@property PowerpointMlDs dashStyle;
@property PowerpointMAhL endArrowheadLength;
@property PowerpointMAhS endArrowheadStyle;
@property PowerpointMAhW endArrowheadWidth;
@property (copy) NSColor *foreColor;
@property PowerpointMCoI foreColorThemeIndex;  // Returns or sets the foreground color for the line.
@property PowerpointPpTy lineFormatPatterned;
@property PowerpointMLnS lineStyle;
@property double lineWeight;
@property double transparency;


@end

@interface PowerpointLinkFormat : PowerpointBaseObject

@property PowerpointPUdO autoUpdate;
@property (copy) NSString *sourceFullName;


@end

// Represents a Microsoft Office theme.
@interface PowerpointOfficeTheme : PowerpointBaseObject

@property (copy, readonly) PowerpointThemeColorScheme *themeColorScheme;  // Returns the color scheme of a Microsoft Office theme.
@property (copy, readonly) PowerpointThemeEffectScheme *themeEffectScheme;  // Returns the effects scheme of a Microsoft Office theme.
@property (copy, readonly) PowerpointThemeFontScheme *themeFontScheme;  // Returns the font scheme of a Microsoft Office theme.


@end

@interface PowerpointPictureFormat : PowerpointBaseObject

@property double brightness;
@property PowerpointMPc colorType;
@property double contrast;
@property double cropBottom;
@property double cropLeft;
@property double cropRight;
@property double cropTop;
@property (copy) NSColor *transparencyColor;
@property BOOL transparentBackground;


@end

@interface PowerpointPlaceholderFormat : PowerpointBaseObject

@property (readonly) PowerpointMShp containedType;
@property (copy) NSString *placeholderName;
@property (readonly) PowerpointPPhd placeholderType;


@end

// Represents the reflection effect in Office graphics.
@interface PowerpointReflectionFormat : PowerpointBaseObject

@property PowerpointMRfT reflectionType;  // Returns or sets the type of the reflection format object.


@end

@interface PowerpointShadowFormat : PowerpointBaseObject

@property double blur;
@property (copy) NSColor *foreColor;
@property PowerpointMCoI foreColorThemeIndex;  // Returns or sets the foreground color for the shadow format.
@property BOOL obscured;
@property double offsetX;
@property double offsetY;
@property BOOL rotateWithShape;  // Returns or sets whether to rotate the shadow when rotating the shape.
@property PowerpointMSSt shadowStyle;  // Returns or sets the style of shadow formatting to apply to a shape.
@property PowerpointMSdT shadowType;
@property double size;  // Returns or sets the width of the shadow.
@property double transparency;
@property BOOL visible;


@end

@interface PowerpointShape : PowerpointBaseObject

- (SBElementArray *) shapes;
- (SBElementArray *) callouts;
- (SBElementArray *) connectors;
- (SBElementArray *) pictures;
- (SBElementArray *) lineShapes;
- (SBElementArray *) placeHolders;
- (SBElementArray *) textBoxes;
- (SBElementArray *) comments;
- (SBElementArray *) shapeTables;
- (SBElementArray *) adjustments;

@property (copy, readonly) PowerpointAnimationSettings *animationSettings;
@property PowerpointMAsT autoShapeType;
@property PowerpointMBSI backgroundStyle;  // Returns or sets the background style.
@property PowerpointMBW blackAndWhiteMode;
@property (readonly) BOOL child;  // True if the shape is a child shape.
@property (readonly) NSInteger connectionSiteCount;
@property (copy, readonly) PowerpointFillFormat *fillFormat;  // Returns a fill format object that contains fill formatting properties for the specified shape.
@property (copy, readonly) PowerpointGlowFormat *glowFormat;  // Returns the formatting properties for a glow effect.
@property (readonly) BOOL hasTable;
@property (readonly) BOOL hasTextFrame;
@property double height;
@property (readonly) BOOL horizontalFlip;
@property (readonly) BOOL isConnector;
@property double leftPosition;
@property (copy, readonly) PowerpointLineFormat *lineFormat;
@property (copy, readonly) PowerpointLinkFormat *linkFormat;
@property BOOL lockAspectRatio;
@property (readonly) PowerpointMedT mediaType;
@property (copy) NSString *name;
@property (copy, readonly) PowerpointReflectionFormat *reflectionFormat;  // Returns the formatting properties for a reflection effect.
@property double rotation;
@property (copy, readonly) PowerpointShadowFormat *shadowFormat;
@property PowerpointMSSI shapeStyle;  // Returns or sets the shape style corresponding to the Quick Styles.
@property (readonly) PowerpointMShp shapeType;
@property (copy, readonly) PowerpointSoftEdgeFormat *softEdgeFormat;  // Returns the formatting properties for a soft edge effect.
@property (copy, readonly) PowerpointTextFrame *textFrame;
@property (copy, readonly) PowerpointThreeDFormat *threeDFormat;  // Returns a threeD format object that contains 3-D-effect formatting properties for the specified shape.
@property double top;
@property (readonly) BOOL verticalFlip;
@property BOOL visible;
@property double width;
@property (copy, readonly) PowerpointWordArtFormat *wordArtFormat;  // Returns the formatting properties for a word art effect.
@property (readonly) NSInteger zOrderPosition;

- (void) apply;
- (void) copyShape;
- (void) cutShape;
- (void) flipDirection:(PowerpointMFlC)direction;
- (PowerpointActionSetting *) getActionSettingForEvent:(PowerpointPMtv)event;
- (void) pickUp;
- (void) rerouteConnections;
- (void) saveAsPicturePictureType:(PowerpointMPiT)pictureType fileName:(NSString *)fileName;  // Saves the shape in the requested file using the stated graphic format
- (void) setShapesDefaultProperties;
- (void) zOrderZOrderPosition:(PowerpointMZoC)zOrderPosition;

@end

@interface PowerpointCallout : PowerpointShape

@property (readonly) PowerpointMCot calloutType;
@property (copy, readonly) PowerpointCalloutFormat *calloutFormat;


@end

@interface PowerpointComment : PowerpointShape


@end

@interface PowerpointConnector : PowerpointShape

@property (copy, readonly) PowerpointConnectorFormat *connectorFormat;
@property (readonly) PowerpointMCtT connectorType;


@end

// The line shape uses begin line X, begin line Y, end line X, and end line Y when created
@interface PowerpointLineShape : PowerpointShape

@property double beginLineX;
@property double beginLineY;
@property double endLineX;
@property double endLineY;


@end

@interface PowerpointMediaObject : PowerpointShape

@property (copy, readonly) NSString *fileName;


@end

@interface PowerpointPicture : PowerpointShape

@property (copy, readonly) NSString *fileName;
@property (readonly) BOOL linkToFile;
@property (copy, readonly) PowerpointPictureFormat *pictureFormat;
@property (readonly) BOOL saveWithDocument;

- (void) scaleHeightFactor:(double)factor relativeToOriginalSize:(BOOL)relativeToOriginalSize scale:(PowerpointMSFr)scale;
- (void) scaleWidthFactor:(double)factor relativeToOriginalSize:(BOOL)relativeToOriginalSize scale:(PowerpointMSFr)scale;

@end

@interface PowerpointPlaceHolder : PowerpointShape

@property (copy, readonly) PowerpointPlaceholderFormat *placeHolderFormat;
@property (readonly) PowerpointPPhd placeholderType;


@end

@interface PowerpointShapeTable : PowerpointShape

@property (readonly) NSInteger numberOfColumns;
@property (readonly) NSInteger numberOfRows;
@property (copy, readonly) PowerpointTable *tableObject;


@end

// Represents the soft edge formatting for a shape or range of shapes
@interface PowerpointSoftEdgeFormat : PowerpointBaseObject

@property PowerpointMSET softEdgeType;  // Returns or sets the type soft edge format object.


@end

@interface PowerpointTextBox : PowerpointShape

@property (readonly) PowerpointTxOr textOrientation;


@end

// Represents a single text column.
@interface PowerpointTextColumn : PowerpointBaseObject

@property NSInteger columnNumber;  // Returns or sets the index of the text column object.
@property double spacing;  // Returns or sets the spacing between text columns in a text column object.
@property PowerpointPDrT textDirection;  // Returns or sets the direction of text in the text column object.


@end

@interface PowerpointTextFrame : PowerpointBaseObject

@property PowerpointPAtS autoSize;
@property (readonly) BOOL hasText;  // Returns whether the specified text frame has text.
@property PowerpointMHzA horizontalAnchor;
@property double marginBottom;
@property double marginLeft;
@property double marginRight;
@property double marginTop;
@property (readonly) PowerpointTxOr orientation;
@property PowerpointMPFo pathFormat;  // Returns or sets the path type for the specified text frame.
@property (copy, readonly) PowerpointRuler *ruler;
@property (copy, readonly) PowerpointTextColumn *textColumn;  // Returns the text column object that represents the columns within the text frame.
@property PowerpointTxOr textOrientation;
@property (copy, readonly) PowerpointTextRange *textRange;
@property (copy, readonly) PowerpointThreeDFormat *threeDFormat;  // Returns the 3-D–effect formatting properties for the specified text.
@property PowerpointMVtA verticalAnchor;
@property PowerpointMWFo warpFormat;  // Returns or sets the warp type for the specified text frame.
@property (readonly) PowerpointMPXF wordArtStylesFormat;  // Returns or sets a value specifying the text effect for the selected text.
@property BOOL wordWrap;  // Returns or sets text break lines within or past the boundaries of the shape.
@property PowerpointMPXF wordartFormat;  // Returns or sets the WordArt type for the specified text frame.


@end

// Represents the color scheme of an Office Theme
@interface PowerpointThemeColorScheme : PowerpointBaseObject

- (SBElementArray *) themeColors;

- (NSColor *) getCustomColorName:(NSString *)name;  // Returns the custom color for the specified Microsoft Office theme.
- (void) loadThemeColorSchemeFileName:(NSString *)fileName;  // Loads the color scheme of a Microsoft Office theme from a file.
- (void) saveThemeColorSchemeFileName:(NSString *)fileName;  // Saves the color scheme of a Microsoft Office theme to a file.

@end

// Represents a color in the color scheme of a Microsoft Office 2007 theme.
@interface PowerpointThemeColor : PowerpointBaseObject

@property (copy) NSColor *RGB;  // Returns or sets a value of a color in the color scheme of a Microsoft Office theme.
@property (readonly) PowerpointMCSI themeColorSchemeIndex;  // Returns the index value a color scheme of a Microsoft Office theme.


@end

// Represents the effect scheme of a Microsoft Office theme.
@interface PowerpointThemeEffectScheme : PowerpointBaseObject

- (void) loadThemeEffectSchemeFileName:(NSString *)fileName;  // Loads the effects scheme of a Microsoft Office theme from a file.

@end

// Represents the font scheme of a Microsoft Office theme.
@interface PowerpointThemeFontScheme : PowerpointBaseObject

- (SBElementArray *) minorThemeFonts;
- (SBElementArray *) majorThemeFonts;

- (void) loadThemeFontSchemeFileName:(NSString *)fileName;  // Loads the font scheme of a Microsoft Office theme from a file.
- (void) saveThemeFontSchemeFileName:(NSString *)fileName;  // Saves the font scheme of a Microsoft Office theme to a file.

@end

// Represents a container for the font schemes of a Microsoft Office theme.
@interface PowerpointThemeFont : PowerpointBaseObject

@property (copy) NSString *name;  // Returns or sets a value specifying the font to use for a selection.


@end

// Represents a container for the font schemes of a Microsoft Office theme.
@interface PowerpointMajorThemeFont : PowerpointThemeFont


@end

// Represents a container for the font schemes of a Microsoft Office theme.
@interface PowerpointMinorThemeFont : PowerpointThemeFont


@end

// Represents a shape's three-dimensional formatting.
@interface PowerpointThreeDFormat : PowerpointBaseObject

@property double ZDistance;  // Returns or sets a Single that represents the distance from the center of an object or text.
@property double bevelBottomDepth;  // Returns or sets the depth/height of the bottom bevel.
@property double bevelBottomInset;  // Returns or sets the inset size/width for the bottom bevel.
@property PowerpointMBlT bevelBottomType;  // Returns or sets the bevel type for the bottom bevel.
@property double bevelTopDepth;  // Returns or sets the depth/height of the top bevel.
@property double bevelTopInset;  // Returns or sets the inset size/width for the top bevel.
@property PowerpointMBlT bevelTopType;  // Returns or sets the bevel type for the top bevel.
@property (copy) NSColor *contourColor;  // Returns or sets the color of the contour of an object or text.
@property PowerpointMCoI contourColorThemeIndex;  // Returns or sets the color for the specified contour.
@property double contourWidth;  // Returns or sets the width of the contour of an object or text.
@property double depth;  // Returns or sets the depth of the shape's extrusion.
@property (copy) NSColor *extrusionColor;
@property PowerpointMCoI extrusionColorThemeIndex;  // Returns or sets the color for the specified extrusion.
@property PowerpointMExC extrusionColorType;  // Returns or sets a RGB color that represents the color of the shape's extrusion.
@property double fieldOfView;  // Returns or sets the amount of perspective for an object or text.
@property double lightAngle;  // Returns or sets the angle of the lighting.
@property BOOL perspective;
@property PowerpointMPzC presetCamera;  // Returns a constant that represents the camera preset.
@property PowerpointMExD presetExtrusionDirection;  // Sets or returns the direction that the extrusion's sweep path takes away from the extruded shape.
@property PowerpointMPLd presetLightingDirection;
@property PowerpointMLtT presetLightingRig;  // Returns a constant that represents the lighting preset.
@property PowerpointMlSf presetLightingSoftness;
@property PowerpointMPMt presetMaterial;
@property PowerpointM3DF presetThreeDFormat;  // Sets or returns the preset extrusion format. Each preset extrusion format contains a set of preset values for the various properties of the extrusion.
@property BOOL projectText;  // Returns or sets whether text on a shape rotates with shape.
@property double rotationX;  // Returns or sets the rotation of the extruded shape around the x-axis in degrees. A positive value indicates upward rotation; a negative value indicates downward rotation.
@property double rotationY;  // Returns or sets the rotation of the extruded shape around the y-axis, in degrees. A positive value indicates rotation to the left; a negative value indicates rotation to the right.
@property double rotationZ;  // Returns or sets the rotation of the extruded shape around the z-axis, in degrees. A positive value indicates clockwise rotation; a negative value indicates anti-clockwise rotation.
@property BOOL visible;


@end

@interface PowerpointWordArtFormat : PowerpointBaseObject

@property BOOL fontBold;
@property BOOL fontItalic;
@property (copy) NSString *fontName;
@property BOOL kernedPairs;
@property BOOL normalizedHeight;
@property PowerpointMPTs presetShape;
@property BOOL rotatedChars;
@property PowerpointMTxA textAlignment;
@property double tracking;
@property PowerpointMPXF wordArtStylesFormat;  // Returns or sets a value specifying the text effect for the selected text.
@property (copy) NSString *wordArtText;

- (void) toggleVerticalText;

@end



/*
 * Text Suite
 */

@interface PowerpointTextRange : PowerpointBaseObject

- (SBElementArray *) characters;
- (SBElementArray *) words;
- (SBElementArray *) sentences;
- (SBElementArray *) lines;
- (SBElementArray *) paragraphs;
- (SBElementArray *) textFlows;

@property (readonly) double boundsHeight;
@property (readonly) double boundsWidth;
@property (copy) NSString *content;
@property (copy, readonly) PowerpointFont *font;
@property NSInteger indentLevel;
@property (readonly) double leftBounds;
@property (readonly) NSInteger offset;
@property (copy, readonly) PowerpointParagraphFormat *paragraphFormat;
@property (readonly) NSInteger textLength;
@property (readonly) double topBounds;

- (void) addPeriodsTo;
- (void) changeCaseTo:(PowerpointPCgC)to;
- (void) copyTextRange;
- (void) cutTextRange;
- (NSArray *) getRotatedTextBounds;  // Returns back a list containing the four point of the text bounds as follows  {x1, y1}, {x2, y2}, {x3, y3}, {x4, y4} }
- (PowerpointActionSetting *) getTextActionSettingResult:(PowerpointPMtv)result;
- (void) insertTextTextRangeInsertWhere:(PowerpointMTiP)insertWhere newText:(NSString *)newText;  // Adds text to existing text.
- (void) pasteTextRange;
- (void) removePeriodsFrom;

@end

@interface PowerpointCharacter : PowerpointTextRange


@end

@interface PowerpointLine : PowerpointTextRange


@end

@interface PowerpointParagraph : PowerpointTextRange


@end

@interface PowerpointSentence : PowerpointTextRange


@end

@interface PowerpointTextFlow : PowerpointTextRange


@end

@interface PowerpointWord : PowerpointTextRange


@end



/*
 * Table Suite
 */

@interface PowerpointCell : PowerpointBaseObject

@property (readonly) BOOL selected;
@property (copy, readonly) PowerpointShape *shape;

- (PowerpointLineFormat *) getBorderEdge:(PowerpointPBrT)edge;
- (void) mergeMergeWith:(PowerpointCell *)mergeWith;
- (void) splitNumberOfRows:(NSInteger)numberOfRows numberOfColumns:(NSInteger)numberOfColumns;

@end

@interface PowerpointColumn : PowerpointBaseObject

- (SBElementArray *) cells;

@property double width;


@end

@interface PowerpointRow : PowerpointBaseObject

- (SBElementArray *) cells;

@property double height;


@end

@interface PowerpointTable : PowerpointBaseObject

- (SBElementArray *) columns;
- (SBElementArray *) rows;

@property PowerpointPDrT tableDirection;

- (PowerpointCell *) getCellFromRow:(NSInteger)row column:(NSInteger)column;

@end

