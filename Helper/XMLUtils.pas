unit XMLUtils;

interface

{$DEFINE XmlUtils_Base64UsePointerMath}

{* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

  This is just a helper and utility class for the Neslib.xml library.

  There's nothing special in it, the initial intention of this unit is to ease and adapt the storage
  (as a kind of serialization) of the properties of some objects

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *}

uses
  System.Classes, System.SysUtils, Neslib.Xml, Neslib.Xml.Types;

type
  EXMLDOMUtilsException = class(Exception);

  TXMLNodeHelper = record helper for TXMLNode
    /// <summary> Find first node with the nodeTag name</summary>
    function SelectNode(const nodeTag: string; var ANode: TXMLNode): Boolean;

    /// <summary> Find last child node</summary>
    function LastChild: TXMLNode;
    /// <summary> Returns the number of childs</summary>
    function ChildCount: NativeInt;

    {$region 'NodeText'}
    function GetNodeText(const nodeTag: string; var Value: String): boolean; overload; inline;
//    procedure GetNodeText(const nodeTag: string; var Value: String); overload;
//    procedure GetNodeText(const nodeTag: string; var Value: Single); overload;
    procedure GetNodeText(const nodeTag: string; var Value: Double); overload;
    procedure GetNodeText(const nodeTag: string; var Value: FixedInt); overload;
    procedure GetNodeText(const nodeTag: string; var Value: NativeInt); overload;
    procedure GetNodeText(const nodeTag: string; var Value: Cardinal); overload;
    procedure GetNodeText(const nodeTag: string; var Value: Int64); overload;
    procedure GetNodeText(const nodeTag: string; var Value: UInt64); overload;
    procedure GetNodeText(const nodeTag: string; var Value: Boolean); overload;
    procedure GetNodeText(const nodeTag: string; var Value: Variant); overload;

    function GetNodeTextStr(const nodeTag: string; const defaultValue: string): String;
    function GetNodeTextInt(const nodeTag: string; defaultValue: FixedInt): FixedInt;
    function GetNodeTextReal(const nodeTag: string; defaultValue: double): double;
    function GetNodeTextBool(const nodeTag: string; defaultValue: Boolean): Boolean;

    /// <summary>Add a node. If the node already exists, its value is updated</summary>
    function  AddNodeText(const nodeTag, Value: string): TXMLNode; inline;
    procedure SetNodeText(const nodeTag: string; const value: String); overload;

//    procedure SetNodeText(const nodeTag: string; value: Single); overload;
    procedure SetNodeText(const nodeTag: string; value: Extended); overload;
    procedure SetNodeText(const nodeTag: string; value: Double); overload;
    function SetNodeText(const nodeTag: string; value: FixedInt): TXMLNode; overload;
    function SetNodeText(const nodeTag: string; value: Cardinal): TXMLNode; overload;
//    class function SetNodeText(parentNode: TXMLNode; const nodeTag: string; value: NativeInt): TXMLNode; overload;
    function SetNodeText(const nodeTag: string; value: Int64): TXMLNode; overload;
    function SetNodeText(const nodeTag: string; value: UInt64): TXMLNode; overload;
    procedure SetNodeText(const nodeTag: string; value: Boolean); overload;
    function SetNodeText(const nodeTag: string; value: Variant): TXMLNode; overload;
    {$endregion 'NodeText'}

    {$region 'Attributes'}
    function GetNodeAttr(const attrName: string; var value: String): boolean; overload; {inline;}
    function GetNodeAttrStr(const attrName: string; const DefaultValue: string): string;
//    function GetNodeAttrInt64(const attrName: string; DefaultValue: int64): int64;
//    function GetNodeAttrBool(const attrName: string; DefaultValue: Boolean = False): Boolean;

//    class function GetNodeAttr(parentNode: IDOMNode; const attrName: string; var value: String): boolean; overload; inline;
    function GetNodeAttr(const attrName: string; defaultValue: double): double; overload;
    function GetNodeAttr(const attrName: string; defaultValue: FixedInt): FixedInt; overload;
    function GetNodeAttr(const attrName: string; defaultValue: Cardinal): Cardinal; overload;
    function GetNodeAttr(const attrName: string; defaultValue: int64): int64; overload;
    function GetNodeAttr(const attrName: string; defaultValue: boolean): boolean; overload;

    /// <summary>Add an attribute. If the attribute already exists, its value is updated</summary>
    procedure AddOrUpdateAttribute(const attrName, Value: string); inline;
    procedure SetNodeAttr(const attrName, value: string); overload;
    procedure SetNodeAttr(const attrName: string; value: double); overload;
    procedure SetNodeAttr(const attrName: string; value: FixedInt); overload;
//    class procedure SetNodeAttr(ANode: TXMLNode; const attrName: string; value: int64); overload;
    procedure SetNodeAttr(const attrName: string; value: boolean); overload;
    procedure SetNodeAttr(const attrName: string; value: int64); overload;
    {$endregion 'Attributes'}
  end;


  TXMLUtils = class(TObject)
  public
    type TBase64 = class(TObject)
    public
      {Decode base64-encoded buffer}
      class function Decode(Encoded, Decoded: Pointer; EncodedSize: NativeInt; var DecodedSize: NativeInt): Boolean; overload;

      {Decode base64-encoded stream}
      class function Decode(const encoded, decoded: TStream): boolean; overload;

      {Decode base64-encoded string}
      class function Decode(const encoded: string; decoded: TStream): boolean; overload;

      {Decode base64-encoded string}
//      class function Decode(const encoded: string; var decoded: string): boolean; overload;

      {Decode base64-encoded string}
//      class function Decode(const encoded: string): string; overload;

      {Encode a buffer into base64 form}
      class function Encode(Decoded, Encoded: Pointer; Size: NativeInt): NativeInt; overload;

      {Encode a stream into base64 form}
      class procedure Encode(const decoded, encoded: TStream); overload;

      {Encode a stream into base64 form}
      class procedure Encode(decoded: TStream; var encoded: XmlString); overload;
      class function Encode(decoded: TStream): XmlString; overload;

      {Encode a stream into base64 form}
//      class function  Encode(decoded: TStream): string; overload;

      {Encode a stream into base64 form}
//      class function  Encode(const decoded: string): string; overload;

      {Encode a string into base64 form}
//      class procedure Encode(const decoded: string; var encoded: string); overload;
    end;

    class function TryEncodeDateTime(aYear, aMonth, aDay, aHour, aMin, aSec,
                              aMSec: Word; var outValue: TDateTime): Boolean;

    class function ISOTryStrToDateTime(const aString: string; var outDateTime: TDateTime): Boolean; inline;
    class function ISOTryStrToBool(const aString: String; var outValue: Boolean): Boolean; inline;
    class function ISOTimeToStr(const aTime: TDateTime): string; inline;
    class function ISODateToStr(const aDate: TDateTime): string; inline;
    class function ISODateTimeToStr(const aDateTime: TDateTime): string; inline;

    class function ISOStrToBoolDef(const aString: string; const aDefValue: Boolean): Boolean;

    class function XMLStrToReal(const AValue: string): double;
    class function XMLStrToDateTime(const AValue: string): TDateTime;
    class function XMLStrToBool(const AValue: string): boolean;
    class function XMLDateTimeToStrEx(value: TDateTime): String;

    /// <summary> Find first node with the nodeTag name</summary>
//    class function SelectNode(ParentNode: TXMLNode; const nodeTag: string; var ANode: TXMLNode): Boolean;
    {:A family of functions that will return attribute value reformatted into
      another type or default value if attribute doesn't exist or if attribute
      is not in a proper format. Basically they all call GetNodeAttr and
      convert the result.
    }

    class procedure SetNodeTextBinary(parentNode: TXMLNode; const nodeTag: string; const value: TStream);
    class function GetNodeTextBinary(parentNode: TXMLNode; const nodeTag: string; value: TStream): boolean;

    class function GetCDataChild(ANode: TXMLNode): TXMLNode;
    class function GetBinaryNodeCData(ANode: TXMLNode; Stream : TStream): Boolean;
    class function SetBinaryCDataChild(ANode: TXMLNode; Stream : TStream): TXMLNode;

    /// <summary>Encodes a stream in a stream (Base64)</summary>
    class function XMLBinaryToStr(const value: TStream): string;
    /// <summary>Decodes a base64 string to a stream</summary>
    class function XMLStrToBinary(const nodeValue: String; const value: TStream): boolean;

    class function SelectNodeValue(ParentNode: TXMLNode; const ElementNode, DetailNode, AValue: String; var outNode: TXMLNode): Boolean;
  end;

implementation

uses Neslib.SysUtils, System.Variants;

const
  cstVarType                = 'vartype';   // don't change!
  DEFAULT_DECIMALSEPARATOR  = '.'; // don't change!
  ISO_BOOL_CONST: array[False..True {aValue}] of string =
    ('0', '1');

  CB64DecodedBufferSize = 52488;
  CB64EncodedBufferSize = 69984;
  CB64InvalidData = $FF;
  CB64PaddingZero = $FE;

var
  ISOFormatSettings : TFormatSettings;  //write only once in initialization section, then read-only => thread-safe!

  B64EncodeTable: array[0..63] of Byte;
  B64DecodeTable: array[0..255] of Byte;

procedure Base64Setup;
var
  i: NativeInt;
begin
  // build encode table
  for i := 0 to 25 do
  begin
    B64EncodeTable[i] := i + Ord('A');
    B64EncodeTable[i+26] := i + Ord('a');
  end;

  for i := 0 to 9 do
    B64EncodeTable[i+52] := i + Ord('0');

  B64EncodeTable[62] := Ord('+');
  B64EncodeTable[63] := Ord('/');

  // build decode table
  for i := 0 to 255 do
  begin
    case i of
      Ord('A')..Ord('Z'): B64DecodeTable[i] := i - Ord('A');
      Ord('a')..Ord('z'): B64DecodeTable[i] := i - Ord('a') + 26;
      Ord('0')..Ord('9'): B64DecodeTable[i] := i - Ord('0') + 52;
      Ord('+'): B64DecodeTable[i] := 62;
      Ord('/'): B64DecodeTable[i] := 63;
      Ord('='): B64DecodeTable[i] := CB64PaddingZero;
    else
      B64DecodeTable[i] := CB64InvalidData;
    end;
  end;
end;

{$IFDEF XmlUtils_Base64UsePointerMath}

function Base64EncodeOptimized(Decoded, Encoded: PByte; Size: NativeInt): NativeInt; overload;
begin
  Result := ((Size + 2) div 3) * 4;

  while Size >= 3 do
  begin
    Encoded[0] := B64EncodeTable[Decoded[0] shr 2];
    Encoded[1] := B64EncodeTable[((Decoded[0] and $03) shl 4) or (Decoded[1] shr 4)];
    Encoded[2] := B64EncodeTable[((Decoded[1] and $0f) shl 2) or (Decoded[2] shr 6)];
    Encoded[3] := B64EncodeTable[Decoded[2] and $3f];

    Inc(Decoded, 3);
    Inc(Encoded, 4);
    Dec(Size, 3);
  end;

  if Size = 1 then
  begin
    Encoded[0] := B64EncodeTable[Decoded[0] shr 2];
    Encoded[1] := B64EncodeTable[(Decoded[0] and $03) shl 4];
    Encoded[2] := Ord('=');
    Encoded[3] := Ord('=');
  end
  else if Size = 2 then
  begin
    Encoded[0] := B64EncodeTable[Decoded[0] shr 2];
    Encoded[1] := B64EncodeTable[((Decoded[0] and $03) shl 4) or (Decoded[1] shr 4)];
    Encoded[2] := B64EncodeTable[(Decoded[1] and $0f) shl 2];
    Encoded[3] := Ord('=');
  end;
end;

{$ELSE}

function Base64EncodeOptimized(Decoded, Encoded: Pointer; Size: NativeInt): NativeInt; overload;
var
  B1, B2, B3: Byte;
  AD: PByte;
  AE: PByte;
begin
  Result := ((Size + 2) div 3) * 4;

  AD := PByte(Decoded);
  AE := PByte(Encoded);

  while Size >= 3 do
  begin
    B1 := AD^;
    Inc(AD);
    B2 := AD^;
    Inc(AD);
    B3 := AD^;
    Inc(AD);

    AE^ := B64EncodeTable[B1 shr 2];
    Inc(AE);
    AE^ := B64EncodeTable[((B1 and $03) shl 4) or (B2 shr 4)];
    Inc(AE);
    AE^ := B64EncodeTable[((B2 and $0f) shl 2) or (B3 shr 6)];
    Inc(AE);
    AE^ := B64EncodeTable[B3 and $3f];
    Inc(AE);

    Dec(Size, 3);
  end;

  if Size = 1 then
  begin
    B1 := AD^;

    AE^ := B64EncodeTable[B1 shr 2];
    Inc(AE);
    AE^ := B64EncodeTable[(B1 and $03) shl 4];
    Inc(AE);
    AE^ := Ord('=');
    Inc(AE);
    AE^ := Ord('=');
  end
  else if Size = 2 then
  begin
    B1 := AD^;
    Inc(AD);
    B2 := AD^;

    AE^ := B64EncodeTable[B1 shr 2];
    Inc(AE);
    AE^ := B64EncodeTable[((B1 and $03) shl 4) or (B2 shr 4)];
    Inc(AE);
    AE^ := B64EncodeTable[(B2 and $0f) shl 2];
    Inc(AE);
    AE^ := Ord('=');
  end;
end;
{$ENDIF}

{ TXMLUtils }

class function TXMLUtils.GetBinaryNodeCData(ANode: TXMLNode; Stream: TStream): Boolean;
var
  cdataNode: TXMLNode;
begin
  Result := False;
  if Stream <> nil then begin
    cdataNode := GetCDataChild(ANode);
    if (cdataNode <> nil) then begin
      Stream.Size := 0;
      TBase64.Decode(cdataNode.Value, Stream);
      Result := Stream.Size > 0;
    end;
  end;
end;

class function TXMLUtils.GetCDataChild(ANode: TXMLNode): TXMLNode;
begin
  Result := ANode.FirstChild;
  while (Result <> nil) do begin
    if Result.NodeType <> TXmlNodeType.CData then
      Result := ANode.NextSibling
    else
      Break;
  end;
end;

class function TXMLUtils.GetNodeTextBinary(parentNode: TXMLNode; const nodeTag: string; value: TStream): boolean;
var
  decoded: TMemoryStream;
begin
  decoded := TMemoryStream.Create;
  try
    Result := XMLStrToBinary(parentNode.GetNodeTextStr(nodeTag, ''), decoded);
    if Result then
      value.CopyFrom(decoded, 0);
  finally
    FreeAndNil(decoded);
  end;
end;

class function TXMLUtils.SelectNodeValue(ParentNode: TXMLNode; const ElementNode, DetailNode, AValue: String; var outNode: TXMLNode): Boolean;
var
  Elm, Detail, EmptyNode: TXMLNode;
begin
  EmptyNode := TXMLNode.Create;  // Create nil node
  outNode := EmptyNode;    // Be sure outnode is nil at start

  Elm := ParentNode.ElementByName(ElementNode);
  while Elm <> nil do begin
    Detail := Elm.ElementByName(DetailNode);

    if Detail.FirstChild.Value = AValue then begin
      OutNode := Elm;
      Break;
    end;

    Elm := Elm.NextSiblingByName(ElementNode);
  end;

  Result := OutNode <> nil;
end;

class function TXMLUtils.SetBinaryCDataChild(ANode: TXMLNode; Stream: TStream): TXMLNode;
begin
  Result := ANode.AddCData(TBase64.Encode(Stream));
end;

class procedure TXMLUtils.SetNodeTextBinary(parentNode: TXMLNode; const nodeTag: string; const value: TStream);
begin
  parentNode.AddNodeText(NodeTag, XMLBinaryToStr(Value));
end;

class function TXMLUtils.TryEncodeDateTime(aYear, aMonth, aDay, aHour,
  aMin, aSec, aMSec: Word; var outValue: TDateTime): Boolean;
var
  xTime: TDateTime;
begin
  Result := TryEncodeDate(aYear, aMonth, aDay, outValue);
  if Result then
  begin
    Result := TryEncodeTime(aHour, aMin, aSec, aMSec, xTime);
    if Result then
      outValue := outValue + xTime;
  end;
end;

class function TXMLUtils.XMLBinaryToStr(const value: TStream): string;
var
  nodeStream: TStringStream;
begin
  value.Position := 0;
  nodeStream := TStringStream.Create('');
  try
    TBase64.Encode(value, nodeStream);
    Result := nodeStream.DataString;
  finally
    FreeAndNil(nodeStream);
  end;
end;

class function TXMLUtils.XMLDateTimeToStrEx(value: TDateTime): String;
begin
  if Trunc(value) = 0 then
    Result := ISOTimeToStr(value)
  else if Frac(Value) = 0 then
    Result := ISODateToStr(value)
  else
    Result := ISODateTimeToStr(value);
end;

class function TXMLUtils.XMLStrToBinary(const nodeValue: String; const value: TStream): boolean;
var
  nodeStream: TStringStream;
begin
  value.Size := 0;
  nodeStream := TStringStream.Create(nodeValue);
  try
    Result := TBase64.Decode(nodeStream, value);
  finally
    FreeAndNil(nodeStream);
  end;
end;

class function TXMLUtils.XMLStrToBool(const AValue: string): boolean;
begin
  if not ISOTryStrToBool(AValue, Result) then
    raise EXMLDOMUtilsException.CreateFmt('%s is not a boolean value', [AValue]);
end;

class function TXMLUtils.XMLStrToDateTime(const AValue: string): TDateTime;
begin
  if not ISOTryStrToDateTime(AValue, Result) then
    raise EXMLDOMUtilsException.CreateFmt('%s is not an ISO datetime value', [AValue]);
end;

class function TXMLUtils.XMLStrToReal(const AValue: string): double;
begin
  Result := StrToFloat(AValue, ISOFormatSettings);
end;

class function TXMLUtils.ISODateTimeToStr(const aDateTime: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss', aDateTime)
end;

class function TXMLUtils.ISODateToStr(const aDate: TDateTime): string;
begin
  Result := FormatDateTime('yyyy-mm-dd', aDate);
end;

class function TXMLUtils.ISOStrToBoolDef(const aString: string; const aDefValue: Boolean): Boolean;
begin
  if not ISOTryStrToBool(aString, Result{%H-}) then
    Result := aDefValue;
end;

class function TXMLUtils.ISOTimeToStr(const aTime: TDateTime): string;
begin
  Result := FormatDateTime('hh:nn:ss', aTime);
end;

class function TXMLUtils.ISOTryStrToBool(const aString: String; var outValue: Boolean): Boolean;
const
  DEFAULT_TRUE_STR          = 'true'; // don't change!
  DEFAULT_FALSE_STR         = 'false'; // don't change!

begin
  case Length(aString) of
    1: begin
      Result := True;
      case aString[1] of
        '1': outValue := True;
        '0': outValue := False;
      else
        Result := False;
      end;
    end;
    4: begin//true
      Result := CompareText(aString, DEFAULT_TRUE_STR) = 0;
      if Result then
        outValue := True;
    end;
    5: begin//false
      Result := CompareText(aString, DEFAULT_FALSE_STR) = 0;
      if Result then
        outValue := False;
    end;
  else
    Result := False;
  end;
end;

class function TXMLUtils.ISOTryStrToDateTime(const aString: string; var outDateTime: TDateTime): Boolean;
var
  xYear, xMonth, xDay, xHour, xMinute, xSecond: FixedInt;
begin
  Result :=
    TryStrToInt(Copy(aString, 1, 4), xYear) and
    TryStrToInt(Copy(aString, 6, 2), xMonth) and
    TryStrToInt(Copy(aString, 9, 2), xDay) and
    TryStrToInt(Copy(aString, 12, 2), xHour) and
    TryStrToInt(Copy(aString, 15, 2), xMinute) and
    TryStrToInt(Copy(aString, 18, 2), xSecond) and
    TryEncodeDateTime(xYear, xMonth, xDay, xHour, xMinute, xSecond, 0, outDateTime);

  if not Result then
    outDateTime := 0;
end;

{ TXMLUtils.TBase64 }

class function TXMLUtils.TBase64.Decode(const encoded: string; decoded: TStream): boolean;
var
  encStr: TStringStream;
begin
  encStr := TStringStream.Create(encoded);
  try
    Result := Decode(encStr, decoded);
  finally
    FreeAndNil(encStr);
  end;
end;


class procedure TXMLUtils.TBase64.Encode(const decoded, encoded: TStream);
var
  DecBuffer: Pointer;
  EncBuffer: Pointer;
  DecSize: NativeInt;
  EncSize: NativeInt;
begin
  if decoded.Size = 0 then
    Exit;

  GetMem(DecBuffer, CB64DecodedBufferSize);
  try
    GetMem(EncBuffer, CB64EncodedBufferSize);
    try
      repeat
        DecSize := decoded.Read(DecBuffer^, CB64DecodedBufferSize);
        EncSize := Encode(DecBuffer, EncBuffer, DecSize);
        encoded.Write(EncBuffer^, EncSize);
      until DecSize <> CB64DecodedBufferSize;
    finally
      FreeMem(EncBuffer);
    end;
  finally
    FreeMem(DecBuffer);
  end;
end;

class function TXMLUtils.TBase64.Encode(decoded: TStream): XmlString;
begin
  Encode(decoded, Result);
end;

class function TXMLUtils.TBase64.Encode(Decoded, Encoded: Pointer; Size: NativeInt): NativeInt;
begin
  Result := Base64EncodeOptimized(Decoded, Encoded, Size);
end;

class procedure TXMLUtils.TBase64.Encode(decoded: TStream; var encoded: XmlString);
var
  encStr: TStringStream;
begin
  encStr := TStringStream.Create('');
  try
    Encode(decoded, encStr);
    encoded := encStr.DataString;
  finally
    FreeAndNil(encStr);
  end;
end;

class function TXMLUtils.TBase64.Decode(const encoded, decoded: TStream): boolean;
var
  EncBuffer: Pointer;
  DecBuffer: Pointer;
  EncSize: NativeInt;
  DecSize: NativeInt;
begin
  Result := True;

  GetMem(EncBuffer, CB64EncodedBufferSize);
  try
    GetMem(DecBuffer, CB64DecodedBufferSize);
    try
      repeat
        EncSize := encoded.Read(EncBuffer^, CB64EncodedBufferSize);
        if Decode(EncBuffer, DecBuffer, EncSize, DecSize) then
          decoded.Write(DecBuffer^, DecSize)
        else
        begin
          Result := False;
          Break;
        end;
      until EncSize <> CB64EncodedBufferSize;
    finally
      FreeMem(DecBuffer);
    end;
  finally
    FreeMem(EncBuffer);
  end;
end;

class function TXMLUtils.TBase64.Decode(Encoded, Decoded: Pointer; EncodedSize: NativeInt; var DecodedSize: NativeInt): Boolean;
var
  AE: PByte;
  AD: PByte;
  QData: array[0..3] of Byte;
  QIndex: NativeInt;
begin
  Result := True;
  if (EncodedSize mod 4) <> 0 then
  begin
    Result := False;
    Exit;
  end;

  DecodedSize := (EncodedSize div 4) * 3;
  AE := PByte(Encoded);
  AD := PByte(Decoded);

  while EncodedSize > 0 do
  begin
    for QIndex := 0 to 3 do
    begin
      QData[QIndex] := B64DecodeTable[AE^];

      case QData[QIndex] of
        CB64InvalidData:
          begin
            Result := False;
            Exit;
          end;
        CB64PaddingZero: Dec(DecodedSize);
      end;

      Inc(AE);
    end;

    AD^ := Byte((QData[0] shl 2) or (QData[1] shr 4));
    Inc(AD);

    if (QData[2] <> CB64PaddingZero) and (QData[3] = CB64PaddingZero) then
    begin
      AD^ := Byte((QData[1] shl 4) or (QData[2] shr 2));
      Inc(AD);
    end
    else if (QData[2] <> CB64PaddingZero) then
    begin
      AD^ := Byte((QData[1] shl 4) or (QData[2] shr 2));
      Inc(AD);
      AD^ := Byte((QData[2] shl 6) or (QData[3]));
      Inc(AD);
    end;

    Dec(EncodedSize, 4);
  end;
end;

{ TXMLNodeHelper }

procedure TXMLNodeHelper.AddOrUpdateAttribute(const attrName, Value: string);
begin
  // Note: AddAttribute from TXMLNode will not check for already existing attribute
  var Attr := AttributeByName(attrName);
  if Attr = nil then
    AddAttribute(attrName, Value)
  else
    Attr.Value := Value;
end;

function TXMLNodeHelper.AddNodeText(const nodeTag, Value: string): TXMLNode;
begin
  Result := ElementByName(nodeTag);
  if Result = nil then begin
    Result := AddElement(nodeTag);
    Result.AddText(Value);
  end
  else
    Result.FirstChild.Value := Value;
end;

function TXMLNodeHelper.ChildCount: NativeInt;
var
  AChild: TXMLNode;
begin
  Result := 0;
  AChild := Self.FirstChild;
  while AChild <> nil do begin
    Inc(Result);
    AChild := AChild.NextSibling;
  end;
end;

function TXMLNodeHelper.GetNodeAttr(const attrName: string; defaultValue: Cardinal): Cardinal;
var
  tmpVal: Int64;
begin
  tmpVal := AttributeByName(attrName).ToInt64(DefaultValue);

  if (tmpVal < Cardinal.MinValue) or (tmpVal > Cardinal.MaxValue) then
    Result := DefaultValue
  else
    Result := Cardinal(tmpVal);
end;

function TXMLNodeHelper.GetNodeAttr(const attrName: string; defaultValue: FixedInt): FixedInt;
begin
  Result := AttributeByName(attrName).ToInteger(DefaultValue);
end;

function TXMLNodeHelper.GetNodeAttr(const attrName: string; defaultValue: double): double;
begin
  Result := AttributeByName(attrName).ToDouble(DefaultValue);
end;

function TXMLNodeHelper.GetNodeAttr(const attrName: string; var value: String): boolean;
var
  AAttrib: TXmlAttribute;
begin
  AAttrib := AttributeByName(attrName);
  Result := AAttrib <> nil;

  if Result then
    value := AAttrib.Value;
end;

function TXMLNodeHelper.GetNodeAttr(const attrName: string; DefaultValue: boolean): boolean;
begin
  Result := AttributeByName(attrName).ToBoolean(DefaultValue);
end;

function TXMLNodeHelper.GetNodeAttr(const attrName: string; defaultValue: int64): int64;
begin
  Result := AttributeByName(attrName).ToInt64(DefaultValue);
end;

function TXMLNodeHelper.GetNodeAttrStr(const attrName, DefaultValue: string): string;
var
  AAttrib: TXmlAttribute;
begin
  AAttrib := AttributeByName(attrName);
  if AAttrib <> nil then
    Result := AAttrib.Value
  else
    Result := DefaultValue;
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: FixedInt);
begin
  var Elm := ElementByName(NodeTag);
  if Elm <> nil then begin
    var Code: FixedInt;
    Val(Elm.FirstChild.Value, Value, Code);
    if Code > 0 then
      Value := 0;
  end;
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: Double);
begin
  // if node not found, don't touch the default value...
  var Elm := ElementByName(NodeTag);
  if Elm <> nil then begin
    var Code: FixedInt;
    Val(Elm.FirstChild.Value, Value, Code);
    if Code > 0 then
      Value := 0;
  end;
end;

function TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: String): boolean;
begin
  var Elm := ElementByName(NodeTag);
  Result := Elm <> nil;

  if Result then
    Value := Elm.FirstChild.Value;
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: Boolean);
begin
  var Elm := ElementByName(NodeTag);
  if not TXMLUtils.ISOTryStrToBool(Elm.FirstChild.Value, Value) then
    Value := False;
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: Int64);
begin
  // if node not found, don't touch the default value...
  var Elm := ElementByName(NodeTag);
  if Elm <> nil then begin
    var Code: FixedInt;
    Val(Elm.FirstChild.Value, Value, Code);
    if Code > 0 then
      Value := 0;
  end;
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: NativeInt);
begin
  var Elm := ElementByName(NodeTag);
  if Elm <> nil then begin
    var Code: FixedInt;
    Val(Elm.FirstChild.Value, Value, Code);
    if Code > 0 then
      Value := 0;
  end;
end;

function TXMLNodeHelper.GetNodeTextInt(const nodeTag: string; defaultValue: FixedInt): FixedInt;
var
  nodeText: String;
begin
//  SetLength(nodeText, 0);
  if GetNodeText(nodeTag, nodeText) then
    Result := StrToIntDef(nodeText, defaultValue)
  else
    Result := defaultValue;
end;

function TXMLNodeHelper.GetNodeTextReal(const nodeTag: string; defaultValue: double): double;
var
  nodeText: String;
begin
  if GetNodeText(nodeTag, nodeText) then
    Result := StrToFloatDef(nodeText, DefaultValue)
  else
    Result := defaultValue;
end;

function TXMLNodeHelper.GetNodeTextStr(const nodeTag, defaultValue: string): String;
var
  nodeText: String;
begin
  if GetNodeText(nodeTag, nodeText) then
    Result := nodeText
  else
    Result := defaultValue;
end;

function TXMLNodeHelper.LastChild: TXMLNode;
var
  HasChild: Boolean;
  AChild: TXMLNode;
begin
  With GetEnumerator do
    While MoveNext do
      Result := Current;
end;

function TXMLNodeHelper.SelectNode(const nodeTag: string; var ANode: TXMLNode): Boolean;
begin
  ANode := ElementByName(nodeTag);
  Result := ANode <> nil;
end;

procedure TXMLNodeHelper.SetNodeAttr(const attrName: string; value: double);
begin
  AddOrUpdateAttribute(attrName, FloatToStr(Value, ISOFormatSettings));
end;

procedure TXMLNodeHelper.SetNodeAttr(const attrName, value: string);
begin
  AddOrUpdateAttribute(attrName, value);
end;

procedure TXMLNodeHelper.SetNodeAttr(const attrName: string; value: int64);
begin
  AddOrUpdateAttribute(attrName, value.ToString);
end;

function TXMLNodeHelper.SetNodeText(const nodeTag: string; value: UInt64): TXMLNode;
begin
  AddNodeText(NodeTag, Value.ToString);
end;

function TXMLNodeHelper.SetNodeText(const nodeTag: string; value: Cardinal): TXMLNode;
begin
  AddNodeText(NodeTag, Value.ToString);
end;

procedure TXMLNodeHelper.SetNodeText(const nodeTag, value: String);
begin
  AddNodeText(NodeTag, Value);
end;

procedure TXMLNodeHelper.SetNodeText(const nodeTag: string; value: Double);
begin
  AddNodeText(NodeTag, FloatToStr(Value, ISOFormatSettings));
end;

procedure TXMLNodeHelper.SetNodeText(const nodeTag: string; value: Boolean);
begin
  AddNodeText(NodeTag, ISO_BOOL_CONST[Value]);
end;

procedure TXMLNodeHelper.SetNodeAttr(const attrName: string; value: boolean);
begin
  AddOrUpdateAttribute(attrName, ISO_BOOL_CONST[Value]);
end;

procedure TXMLNodeHelper.SetNodeAttr(const attrName: string; value: FixedInt);
begin
  AddOrUpdateAttribute(attrName, value.ToString);
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: Variant);
var
  myNode {, attrNode}: TXMLNode;
  VarAttrib: TXmlAttribute;
  ValueType: FixedInt;
begin
  if SelectNode(nodeTag, myNode) then begin
    VarAttrib := myNode.AttributeByName(cstVarType);

//    if MyNode.GetNodeAttr(cstVarType, attrNode) then begin
    if VarAttrib <> nil then begin
      ValueType := varEmpty;
      TryStrToInt(VarAttrib.Value, ValueType);

      myNode := myNode.FirstChild;

      if myNode <> nil then begin
        try
          case ValueType of
            varSmallInt,
            varInteger,
            varShortInt,
            varByte,
            varWord,
            varLongWord:
              Value := StrToInt(myNode.Value);

            varInt64,
            varUInt64:
              Value := StrToInt64(myNode.Value);

            varSingle, varDouble, varCurrency:
              Value := TXMLUtils.XMLStrToReal(myNode.Value);
            varDate:
              Value := TXMLUtils.XMLStrToDateTime(myNode.Value);
            varBoolean:
              Value := TXMLUtils.XMLStrToBool(myNode.Value);
            else
              Value := myNode.Value;
          end;
        except
          on EConvertError do
            Value := null;
        end;
      end;
    end
    else
      Value := null;
  end
  else
    Value := null;
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: UInt64);
var
  AStrValue: string;
  Code : FixedInt;
begin
  // if node not found, don't touch the default value...
  if GetNodeText(nodeTag, AStrValue) then begin
    Val(AStrValue, Value, Code);
    if Code > 0 then
      Value := 0;
  end;
end;

function TXMLNodeHelper.GetNodeTextBool(const nodeTag: string; defaultValue: Boolean): Boolean;
var
  nodeText: String;
begin
  if GetNodeText(nodeTag, nodeText) then
    Result := TXMLUtils.ISOStrToBoolDef(nodeText, defaultValue)
  else
    Result := defaultValue;
end;

procedure TXMLNodeHelper.GetNodeText(const nodeTag: string; var Value: Cardinal);
begin
  var Elm := ElementByName(NodeTag);
  if Elm <> nil then begin
    var Code: FixedInt;
    Val(Elm.Value, Value, Code);
    if Code > 0 then
      Value := 0;
  end;
end;

function TXMLNodeHelper.SetNodeText(const nodeTag: string; value: Variant): TXMLNode;
var
  sTmp: string;
begin
  Result := AddNodeText(nodeTag, '');
  Result.SetNodeAttr(cstVarType, VarType(value).ToString);

  case VarType(value) of
    varEmpty, varNull: ; // do nothing
    varSmallInt,
    varInteger,
    varShortInt,
    varByte,
    varWord,
    varLongWord,
    varInt64:
      sTmp := Int64(value).ToString;

    varUInt64:
      sTmp :=  UInt64(value).ToString;

    varSingle, varDouble, varCurrency:
      sTmp := FloatToStr(value, ISOFormatSettings);
    varDate:
      sTmp := TXMLUtils.XMLDateTimeToStrEx(value);
    varBoolean:
      sTmp := ISO_BOOL_CONST[Boolean(Value)];
    else
      sTmp := Value;
  end; //case

  Result.AddText(sTmp);
end;

//procedure TXMLNodeHelper.SetNodeText(const nodeTag: string; value: Single);
//begin
//  AddNodeText(NodeTag, FloatToStr(Value, ISOFormatSettings));
//end;

procedure TXMLNodeHelper.SetNodeText(const nodeTag: string; value: Extended);
begin
  AddNodeText(NodeTag, FloatToStr(Value, ISOFormatSettings));
end;

function TXMLNodeHelper.SetNodeText(const nodeTag: string; value: Int64): TXMLNode;
begin
  AddNodeText(NodeTag, Value.ToString);
end;

function TXMLNodeHelper.SetNodeText(const nodeTag: string; value: FixedInt): TXMLNode;
begin
  AddNodeText(NodeTag, Value.ToString);
end;

Initialization
  Base64Setup;
  FillChar(ISOFormatSettings{%H-}, SizeOf(ISOFormatSettings), 0);
  ISOFormatSettings.DecimalSeparator := DEFAULT_DECIMALSEPARATOR;

end.
