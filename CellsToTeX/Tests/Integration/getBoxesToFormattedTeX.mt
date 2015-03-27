(* Mathematica Test File *)

(* ::Section:: *)
(*SetUp*)


BeginPackage[
	"CellsToTeX`Tests`Integration`getBoxesToFormattedTeX`", {"MUnit`"}
]


Get["CellsToTeX`"]


With[{boxRules = CellsToTeX`Configuration`getBoxesToFormattedTeX[]},
	tmpBoxesToString =
		CellsToTeX`Internal`boxesToString[
			#, boxRules, FormatType -> InputForm
		]&
]


(* ::Section:: *)
(*Tests*)


Test[
	"\[RightSkeleton]" // tmpBoxesToString
	,
	">>"
	,
	TestID -> "\\[RightSkeleton]"
]
Test[
	"\[CapitalPi]" // tmpBoxesToString
	,
	"\\(\\Pi\\)"
	,
	TestID -> "\\[CapitalPi]"
]
Test[
	"\[Infinity]" // tmpBoxesToString
	,
	"\\(\\infty\\)"
	,
	TestID -> "\\[Infinity]"
]

Test[
	"\\" // tmpBoxesToString
	,
	"\\textbackslash{}"
	,
	TestID -> "\\"
]
Test[
	"{" // tmpBoxesToString
	,
	"\\{"
	,
	TestID -> "{"
]
Test[
	"}" // tmpBoxesToString
	,
	"\\}"
	,
	TestID -> "}"
]


Test[
	StyleBox[StyleBox["a", Red], Green] // tmpBoxesToString
	,
	"a"
	,
	TestID -> "linear box"
]

Test[
	SubscriptBox["\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaSub{\\pi}{\\(\\pi\\)}"
	,
	TestID -> "SubscriptBox: math mode"
]
Test[
	SubscriptBox[SubscriptBox["a", "b"], SubscriptBox["c", "d"]] //
		tmpBoxesToString
	,
	"\\mmaSub{\\mmaSub{a}{b}}{\\mmaSub{c}{d}}"
	,
	TestID -> "SubscriptBox: nested"
]

Test[
	SuperscriptBox["\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaSup{\\pi}{\\(\\pi\\)}"
	,
	TestID -> "SuperscriptBox: math mode"
]
Test[
	SuperscriptBox[SuperscriptBox["a", "b"], SuperscriptBox["c", "d"]] //
		tmpBoxesToString
	,
	"\\mmaSup{\\mmaSup{a}{b}}{\\mmaSup{c}{d}}"
	,
	TestID -> "SuperscriptBox: nested"
]

Test[
	SubsuperscriptBox["\[Pi]", "\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaSubSup{\\pi}{\\(\\pi\\)}{\\(\\pi\\)}"
	,
	TestID -> "SubsuperscriptBox: math mode"
]
Test[
	SubsuperscriptBox[
		SubsuperscriptBox["a", "b", "c"],
		SubsuperscriptBox["d", "e", "f"],
		SubsuperscriptBox["g", "h", "i"]
	] // tmpBoxesToString
	,
	"\
\\mmaSubSup{\\mmaSubSup{a}{b}{c}}{\\mmaSubSup{d}{e}{f}}{\\mmaSubSup{g}{h}{i}}"
	,
	TestID -> "SubsuperscriptBox: nested"
]

Test[
	UnderscriptBox["\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaUnder{\\pi}{\\(\\pi\\)}"
	,
	TestID -> "UnderscriptBox: math mode"
]
Test[
	UnderscriptBox[UnderscriptBox["a", "b"], UnderscriptBox["c", "d"]] //
		tmpBoxesToString
	,
	"\\mmaUnder{\\mmaUnder{a}{b}}{\\mmaUnder{c}{d}}"
	,
	TestID -> "UnderscriptBox: nested"
]

Test[
	OverscriptBox["\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaOver{\\pi}{\\(\\pi\\)}"
	,
	TestID -> "OverscriptBox: math mode"
]
Test[
	OverscriptBox[OverscriptBox["a", "b"], OverscriptBox["c", "d"]] //
		tmpBoxesToString
	,
	"\\mmaOver{\\mmaOver{a}{b}}{\\mmaOver{c}{d}}"
	,
	TestID -> "OverscriptBox: nested"
]

Test[
	UnderoverscriptBox["\[Pi]", "\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaUnderOver{\\pi}{\\(\\pi\\)}{\\(\\pi\\)}"
	,
	TestID -> "UnderoverscriptBox: math mode"
]
Test[
	UnderoverscriptBox[
		UnderoverscriptBox["a", "b", "c"],
		UnderoverscriptBox["d", "e", "f"],
		UnderoverscriptBox["g", "h", "i"]
	] // tmpBoxesToString
	,
	"\\mmaUnderOver\
{\\mmaUnderOver{a}{b}{c}}{\\mmaUnderOver{d}{e}{f}}{\\mmaUnderOver{g}{h}{i}}"
	,
	TestID -> "UnderoverscriptBox: nested"
]

Test[
	FractionBox["\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaFrac{\\(\\pi\\)}{\\(\\pi\\)}"
	,
	TestID -> "FractionBox: math mode"
]
Test[
	FractionBox[FractionBox["a", "b"], FractionBox["c", "d"]] //
		tmpBoxesToString
	,
	"\\mmaFrac{\\mmaFrac{a}{b}}{\\mmaFrac{c}{d}}"
	,
	TestID -> "FractionBox: nested"
]

Test[
	SqrtBox["\[Pi]"] // tmpBoxesToString
	,
	"\\mmaSqrt{\\pi}"
	,
	TestID -> "SqrtBox: math mode"
]
Test[
	SqrtBox[SqrtBox["a"]] // tmpBoxesToString
	,
	"\\mmaSqrt{\\mmaSqrt{a}}"
	,
	TestID -> "SqrtBox: nested"
]

Test[
	RadicalBox["\[Pi]", "\[Pi]"] // tmpBoxesToString
	,
	"\\mmaRadical{\\pi}{\\(\\pi\\)}"
	,
	TestID -> "RadicalBox: math mode"
]
Test[
	RadicalBox[RadicalBox["a", "b"], RadicalBox["c", "d"]] //
		tmpBoxesToString
	,
	"\\mmaRadical{\\mmaRadical{a}{b}}{\\mmaRadical{c}{d}}"
	,
	TestID -> "RadicalBox: nested"
]

If[$VersionNumber >= 10,
	Block[{a, b},
		Test[
			"<|a->b|>" // ToExpression // ToBoxes // tmpBoxesToString
			,
			"<|a\\(\\to\\)b|>"
			,
			TestID -> "Association"
		]
	]
]


(* ::Section:: *)
(*TearDown*)


Unprotect["`*"]
Quiet[Remove["`*"], {Remove::rmnsm}]


EndPackage[]
$ContextPath = Rest[$ContextPath]