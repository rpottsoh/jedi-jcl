{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is Vector.pas.                                                                 }
{                                                                                                  }
{ The Initial Developer of the Original Code is Jean-Philippe BEMPEL aka RDM. Portions created by  }
{ Jean-Philippe BEMPEL are Copyright (C) Jean-Philippe BEMPEL (rdm_30 att yahoo dott com)          }
{ All rights reserved.                                                                             }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ The Delphi Container Library                                                                     }
{                                                                                                  }
{**************************************************************************************************}

// Last modified: $Date$
// For history see end of file

unit JclVectors;

{$I jcl.inc}

interface

uses
  Classes,
  JclBase, JclAbstractContainers, JclContainerIntf;

type
  TJclIntfVector = class(TJclAbstractContainer, IJclIntfCollection, IJclIntfList,
    IJclIntfArray, IJclIntfCloneable)
  private
    FCount: Integer;
    FCapacity: Integer;
  protected
    procedure Grow; virtual;
    { IJclCloneable }
    function Clone: IInterface;
  public
    Items: TDynIInterfaceArray;
    { IJclIntfCollection }
    function Add(AInterface: IInterface): Boolean; overload;
    function AddAll(ACollection: IJclIntfCollection): Boolean; overload;
    procedure Clear;
    function Contains(AInterface: IInterface): Boolean;
    function ContainsAll(ACollection: IJclIntfCollection): Boolean;
    function Equals(ACollection: IJclIntfCollection): Boolean;
    function First: IJclIntfIterator;
    function IsEmpty: Boolean;
    function Last: IJclIntfIterator;
    function Remove(AInterface: IInterface): Boolean; overload;
    function RemoveAll(ACollection: IJclIntfCollection): Boolean;
    function RetainAll(ACollection: IJclIntfCollection): Boolean;
    function Size: Integer;
    { IJclIntfList }
    procedure Insert(Index: Integer; AInterface: IInterface); overload;
    function InsertAll(Index: Integer; ACollection: IJclIntfCollection): Boolean; overload;
    function GetObject(Index: Integer): IInterface;
    function IndexOf(AInterface: IInterface): Integer;
    function LastIndexOf(AInterface: IInterface): Integer;
    function Remove(Index: Integer): IInterface; overload;
    procedure SetObject(Index: Integer; AInterface: IInterface);
    function SubList(First, Count: Integer): IJclIntfList;

    constructor Create(ACapacity: Integer = DefaultContainerCapacity);
    destructor Destroy; override;
    procedure AfterConstruction; override;
    // Do not decrement RefCount because iterator inc/dec it.
    procedure BeforeDestruction; override;
  end;

  TJclStrVector = class(TJclAbstractContainer, IJclStrCollection, IJclStrList,
    IJclStrArray, IJclCloneable)
  private
    FCount: Integer;
    FCapacity: Integer;
  protected
    procedure Grow; virtual;
    { IJclCloneable }
    function Clone: TObject;
  public
    Items: TDynStringArray;
    { IJclStrCollection }
    function Add(const AString: string): Boolean; overload;
    function AddAll(ACollection: IJclStrCollection): Boolean; overload;
    procedure Clear;
    function Contains(const AString: string): Boolean;
    function ContainsAll(ACollection: IJclStrCollection): Boolean;
    function Equals(ACollection: IJclStrCollection): Boolean;
    function First: IJclStrIterator;
    function IsEmpty: Boolean;
    function Last: IJclStrIterator;
    function Remove(const AString: string): Boolean; overload;
    function RemoveAll(ACollection: IJclStrCollection): Boolean;
    function RetainAll(ACollection: IJclStrCollection): Boolean;
    function Size: Integer;
    //Daniele Teti 27/12/2004
    procedure LoadFromStrings(Strings: TStrings);
    procedure SaveToStrings(Strings: TStrings);
    procedure AppendToStrings(Strings: TStrings);
    procedure AppendFromStrings(Strings: TStrings);
    function GetAsStrings: TStrings;
    function GetAsDelimited(Separator: string = AnsiLineBreak): string;
    procedure AppendDelimited(AString: string; Separator: string = AnsiLineBreak);
    procedure LoadDelimited(AString: string; Separator: string = AnsiLineBreak);
    { IJclStrList }
    procedure Insert(Index: Integer; const AString: string); overload;
    function InsertAll(Index: Integer; ACollection: IJclStrCollection): Boolean; overload;
    function GetString(Index: Integer): string;
    function IndexOf(const AString: string): Integer;
    function LastIndexOf(const AString: string): Integer;
    function Remove(Index: Integer): string; overload;
    procedure SetString(Index: Integer; const AString: string);
    function SubList(First, Count: Integer): IJclStrList;

    constructor Create(ACapacity: Integer = DefaultContainerCapacity);
    destructor Destroy; override;
    procedure AfterConstruction; override;
    // Do not decrement RefCount because iterator inc/dec it.
    procedure BeforeDestruction; override;
  end;

  TJclVector = class(TJclAbstractContainer, IJclCollection, IJclList, IJclArray,
    IJclCloneable)
  private
    FCount: Integer;
    FCapacity: Integer;
    FOwnsObjects: Boolean;
  protected
    procedure Grow; virtual;
    procedure FreeObject(var AObject: TObject);
  public
    Items: TDynObjectArray;
    { IJclCollection }
    function Add(AObject: TObject): Boolean; overload;
    function AddAll(ACollection: IJclCollection): Boolean; overload;
    procedure Clear;
    function Contains(AObject: TObject): Boolean;
    function ContainsAll(ACollection: IJclCollection): Boolean;
    function Equals(ACollection: IJclCollection): Boolean;
    function First: IJclIterator;
    function IsEmpty: Boolean;
    function Last: IJclIterator;
    function Remove(AObject: TObject): Boolean; overload;
    function RemoveAll(ACollection: IJclCollection): Boolean;
    function RetainAll(ACollection: IJclCollection): Boolean;
    function Size: Integer;
    { IJclList }
    procedure Insert(Index: Integer; AObject: TObject); overload;
    function InsertAll(Index: Integer; ACollection: IJclCollection): Boolean; overload;
    function GetObject(Index: Integer): TObject;
    function IndexOf(AObject: TObject): Integer;
    function LastIndexOf(AObject: TObject): Integer;
    function Remove(Index: Integer): TObject; overload;
    procedure SetObject(Index: Integer; AObject: TObject);
    function SubList(First, Count: Integer): IJclList;
    { IJclCloneable }
    function Clone: TObject;

    constructor Create(ACapacity: Integer = DefaultContainerCapacity; AOwnsObjects: Boolean = True);
    destructor Destroy; override;
    procedure AfterConstruction; override;
    // Do not decrement RefCount because iterator inc/dec it.
    procedure BeforeDestruction; override;
    property OwnsObjects: Boolean read FOwnsObjects;
  end;

implementation

uses
  JclAlgorithms, JclResources;

type
  TIntfItr = class(TJclAbstractContainer, IJclIntfIterator)
  private
    FCursor: Integer;
    FOwnList: TJclIntfVector;
    FLastRet: Integer;
    FSize: Integer;
  protected
    { IJclIntfIterator}
    procedure Add(AInterface: IInterface);
    function GetObject: IInterface;
    function HasNext: Boolean;
    function HasPrevious: Boolean;
    function Next: IInterface;
    function NextIndex: Integer;
    function Previous: IInterface;
    function PreviousIndex: Integer;
    procedure Remove;
    procedure SetObject(AInterface: IInterface);
  public
    constructor Create(OwnList: TJclIntfVector);
    destructor Destroy; override;
  end;

  TStrItr = class(TJclAbstractContainer, IJclStrIterator)
  private
    FCursor: Integer;
    FOwnList: TJclStrVector;
    FLastRet: Integer;
    FSize: Integer;
  protected
    { IJclStrIterator}
    procedure Add(const AString: string);
    function GetString: string;
    function HasNext: Boolean;
    function HasPrevious: Boolean;
    function Next: string;
    function NextIndex: Integer;
    function Previous: string;
    function PreviousIndex: Integer;
    procedure Remove;
    procedure SetString(const AString: string);
  public
    constructor Create(OwnList: TJclStrVector);
    destructor Destroy; override;
  end;

  TItr = class(TJclAbstractContainer, IJclIterator)
  private
    FCursor: Integer;
    FOwnList: TJclVector;
    FLastRet: Integer;
    FSize: Integer;
  protected
    { IJclIterator}
    procedure Add(AObject: TObject);
    function GetObject: TObject;
    function HasNext: Boolean;
    function HasPrevious: Boolean;
    function Next: TObject;
    function NextIndex: Integer;
    function Previous: TObject;
    function PreviousIndex: Integer;
    procedure Remove;
    procedure SetObject(AObject: TObject);
  public
    constructor Create(OwnList: TJclVector);
    destructor Destroy; override;
  end;

//=== { TIntfItr } ===========================================================

constructor TIntfItr.Create(OwnList: TJclIntfVector);
begin
  inherited Create;
  FCursor := 0;
  FOwnList := OwnList;
  FOwnList._AddRef; // Add a ref because FOwnList is not an interface !
  FLastRet := -1;
  FSize := FOwnList.Size;
end;

destructor TIntfItr.Destroy;
begin
  FOwnList._Release;
  inherited Destroy;
end;

procedure TIntfItr.Add(AInterface: IInterface);
begin
  with FOwnList do
  begin
    System.Move(Items[FCursor], Items[FCursor + 1],
      (FCount - FCursor) * SizeOf(TObject));
    FCapacity := Length(Items);
    Items[FCursor] := AInterface;
    Inc(FCount);
  end;
  Inc(FSize);
  Inc(FCursor);
  FLastRet := -1;
end;

function TIntfItr.GetObject: IInterface;
begin
  Result := FOwnList.Items[FCursor];
end;

function TIntfItr.HasNext: Boolean;
begin
  Result := FCursor <> FSize;
end;

function TIntfItr.HasPrevious: Boolean;
begin
  Result := FCursor > 0;
end;

function TIntfItr.Next: IInterface;
begin
  Result := FOwnList.Items[FCursor];
  FLastRet := FCursor;
  Inc(FCursor);
end;

function TIntfItr.NextIndex: Integer;
begin
  Result := FCursor;
end;

function TIntfItr.Previous: IInterface;
begin
  Dec(FCursor);
  FLastRet := FCursor;
  Result := FOwnList.Items[FCursor];
end;

function TIntfItr.PreviousIndex: Integer;
begin
  Result := FCursor - 1;
end;

procedure TIntfItr.Remove;
begin
  with FOwnList do
  begin
    Items[FCursor] := nil; // Force Release
    System.Move(Items[FCursor + 1], Items[FCursor],
      (FSize - FCursor) * SizeOf(IInterface));
  end;
  Dec(FOwnList.FCount);
  Dec(FSize);
end;

procedure TIntfItr.SetObject(AInterface: IInterface);
begin
  FOwnList.Items[FCursor] := AInterface;
end;

//=== { TStrItr } ============================================================

constructor TStrItr.Create(OwnList: TJclStrVector);
begin
  inherited Create;
  FCursor := 0;
  FOwnList := OwnList;
  FOwnList._AddRef; // Add a ref because FOwnList is not an interface !
  FLastRet := -1;
  FSize := FOwnList.Size;
end;

destructor TStrItr.Destroy;
begin
  FOwnList._Release;
  inherited Destroy;
end;

procedure TStrItr.Add(const AString: string);
begin
  with FOwnList do
  begin
    System.Move(Items[FCursor], Items[FCursor + 1],
      (FOwnList.FCount - FCursor) * SizeOf(string));
    FCapacity := Length(Items);
    Items[FCursor] := AString;
    Inc(FOwnList.FCount);
  end;
  Inc(FSize);
  Inc(FCursor);
  FLastRet := -1;
end;

function TStrItr.GetString: string;
begin
  Result := FOwnList.Items[FCursor];
end;

function TStrItr.HasNext: Boolean;
begin
  Result := FCursor < FSize;
end;

function TStrItr.HasPrevious: Boolean;
begin
  Result := FCursor > 0;
end;

function TStrItr.Next: string;
begin
  Result := FOwnList.Items[FCursor];
  FLastRet := FCursor;
  Inc(FCursor);
end;

function TStrItr.NextIndex: Integer;
begin
  Result := FCursor;
end;

function TStrItr.Previous: string;
begin
  Dec(FCursor);
  FLastRet := FCursor;
  Result := FOwnList.Items[FCursor];
end;

function TStrItr.PreviousIndex: Integer;
begin
  Result := FCursor - 1;
end;

procedure TStrItr.Remove;
begin
  with FOwnList do
  begin
    Items[FCursor] := ''; // Force Release
    System.Move(Items[FCursor + 1], Items[FCursor],
      (FSize - FCursor) * SizeOf(string));
  end;
  Dec(FOwnList.FCount);
  Dec(FSize);
end;

procedure TStrItr.SetString(const AString: string);
begin
  {
  if FLastRet = -1 then
    raise EJclIllegalState.Create(SIllegalState);
  }
  FOwnList.Items[FCursor] := AString;
end;

//=== { TItr } ===============================================================

constructor TItr.Create(OwnList: TJclVector);
begin
  inherited Create;
  FCursor := 0;
  FOwnList := OwnList;
  FOwnList._AddRef; // Add a ref because FOwnList is not an interface !
  FLastRet := -1;
  FSize := FOwnList.Size;
end;

destructor TItr.Destroy;
begin
  FOwnList._Release;
  inherited Destroy;
end;

procedure TItr.Add(AObject: TObject);
begin
  with FOwnList do
  begin
    System.Move(Items[FCursor], Items[FCursor + 1],
      (FCount - FCursor) * SizeOf(TObject));
    FCapacity := Length(Items);
    Items[FCursor] := AObject;
    Inc(FCount);
  end;
  Inc(FSize);
  Inc(FCursor);
  FLastRet := -1;
end;

function TItr.GetObject: TObject;
begin
  Result := FOwnList.Items[FCursor];
end;

function TItr.HasNext: Boolean;
begin
  Result := FCursor <> FSize;
end;

function TItr.HasPrevious: Boolean;
begin
  Result := FCursor > 0;
end;

function TItr.Next: TObject;
begin
  Result := FOwnList.Items[FCursor];
  FLastRet := FCursor;
  Inc(FCursor);
end;

function TItr.NextIndex: Integer;
begin
  Result := FCursor;
end;

function TItr.Previous: TObject;
begin
  Dec(FCursor);
  FLastRet := FCursor;
  Result := FOwnList.Items[FCursor];
end;

function TItr.PreviousIndex: Integer;
begin
  Result := FCursor - 1;
end;

procedure TItr.Remove;
begin
  with FOwnList do
  begin
    FreeObject(Items[FCursor]);
    System.Move(Items[FCursor + 1], Items[FCursor],
      (FSize - FCursor) * SizeOf(TObject));
  end;
  Dec(FOwnList.FCount);
  Dec(FSize);
end;

procedure TItr.SetObject(AObject: TObject);
begin
  {
  if FLastRet = -1 then
    raise EJclIllegalState.Create(SIllegalState);
  }
  FOwnList.Items[FCursor] := AObject;
end;

//=== { TJclIntfVector } =====================================================

constructor TJclIntfVector.Create(ACapacity: Integer = DefaultContainerCapacity);
begin
  inherited Create;
  FCount := 0;
  if ACapacity < 0 then
    FCapacity := 0
  else
    FCapacity := ACapacity;
  SetLength(Items, FCapacity);
end;

destructor TJclIntfVector.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TJclIntfVector.Insert(Index: Integer; AInterface: IInterface);
begin
  if (Index < 0) or (Index > FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  System.Move(Items[Index], Items[Index - 1],
    (FCount - Index) * SizeOf(IInterface));
  FCapacity := Length(Items);
  Items[Index] := AInterface;
  Inc(FCount);
end;

function TJclIntfVector.Add(AInterface: IInterface): Boolean;
begin
  if FCount = FCapacity then
    Grow;
  Items[FCount] := AInterface;
  Inc(FCount);
  Result := True;
end;

function TJclIntfVector.InsertAll(Index: Integer; ACollection: IJclIntfCollection): Boolean;
var
  It: IJclIntfIterator;
  Size: Integer;
begin
  Result := False;
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  if ACollection = nil then
    Exit;
  Size := ACollection.Size;
  System.Move(Items[Index], Items[Index + Size], Size * SizeOf(IInterface));
  It := ACollection.First;
  while It.HasNext do
  begin
    Items[Index] := It.Next;
    Inc(Index);
  end;
  Result := True;
end;

function TJclIntfVector.AddAll(ACollection: IJclIntfCollection): Boolean;
var
  It: IJclIntfIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    Add(It.Next);
  Result := True;
end;

procedure TJclIntfVector.Clear;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    Items[I] := nil;
  FCount := 0;
end;

function TJclIntfVector.Clone: IInterface;
var
  NewList: IJclIntfList;
begin
  NewList := TJclIntfVector.Create(FCapacity);
  NewList.AddAll(Self);
  Result := NewList;
end;

function TJclIntfVector.Contains(AInterface: IInterface): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AInterface = nil then
    Exit;
  for I := 0 to FCount - 1 do
    if Items[I] = AInterface then
    begin
      Result := True;
      Break;
    end;
end;

function TJclIntfVector.ContainsAll(ACollection: IJclIntfCollection): Boolean;
var
  It: IJclIntfIterator;
begin
  Result := True;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    if not Contains(It.Next) then
    begin
      Result := False;
      Break;
    end;
end;

function TJclIntfVector.Equals(ACollection: IJclIntfCollection): Boolean;
var
  I: Integer;
  It: IJclIntfIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  if FCount <> ACollection.Size then
    Exit;
  It := ACollection.First;
  for I := 0 to FCount - 1 do
    if Items[I] <> It.Next then
      Exit;
  Result := True;
end;

function TJclIntfVector.GetObject(Index: Integer): IInterface;
begin
  if (Index < 0) or (Index >= FCount) then
  begin
    Result := nil;
    Exit;
  end;
  Result := Items[Index];
end;

procedure TJclIntfVector.Grow;
begin
  if FCapacity > 64 then
    FCapacity := FCapacity + FCapacity div 4
  else
    FCapacity := FCapacity * 4;
  SetLength(Items, FCapacity);
end;

function TJclIntfVector.IndexOf(AInterface: IInterface): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AInterface = nil then
    Exit;
  for I := 0 to FCount - 1 do
    if Items[I] = AInterface then
    begin
      Result := I;
      Break;
    end;
end;

function TJclIntfVector.First: IJclIntfIterator;
begin
  Result := TIntfItr.Create(Self);
end;

function TJclIntfVector.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TJclIntfVector.Last: IJclIntfIterator;
var
  NewIterator: TIntfItr;
begin
  NewIterator := TIntfItr.Create(Self);
  NewIterator.FCursor := NewIterator.FOwnList.FCount;
  NewIterator.FSize := NewIterator.FOwnList.FCount;
  Result := NewIterator;
end;

function TJclIntfVector.LastIndexOf(AInterface: IInterface): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AInterface = nil then
    Exit;
  for I := FCount - 1 downto 0 do
    if Items[I] = AInterface then
    begin
      Result := I;
      Break;
    end;
end;

function TJclIntfVector.Remove(Index: Integer): IInterface;
begin
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  Result := Items[Index];
  Items[Index] := nil;
  System.Move(Items[Index + 1], Items[Index],
    (FCount - Index) * SizeOf(IInterface));
  Dec(FCount);
end;

function TJclIntfVector.Remove(AInterface: IInterface): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AInterface = nil then
    Exit;
  for I := FCount - 1 downto 0 do
    if Items[I] = AInterface then // Removes all AInterface
    begin
      Items[I] := nil; // Force Release
      System.Move(Items[I + 1], Items[I], (FCount - I) * SizeOf(IInterface));
      Dec(FCount);
      Result := True;
    end;
end;

function TJclIntfVector.RemoveAll(ACollection: IJclIntfCollection): Boolean;
var
  It: IJclIntfIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    Remove(It.Next);
end;

function TJclIntfVector.RetainAll(ACollection: IJclIntfCollection): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  for I := FCount - 1 downto 0 do
    if not ACollection.Contains(Items[I]) then
      Remove(I);
end;

procedure TJclIntfVector.SetObject(Index: Integer; AInterface: IInterface);
begin
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  Items[Index] := AInterface;
end;

function TJclIntfVector.Size: Integer;
begin
  Result := FCount;
end;

function TJclIntfVector.SubList(First, Count: Integer): IJclIntfList;
var
  I: Integer;
  Last: Integer;
begin
  Last := First + Count - 1;
  if Last >= FCount then
    Last := FCount - 1;
  Result := TJclIntfVector.Create(Count);
  for I := First to Last do
    Result.Add(Items[I]);
end;

procedure TJclIntfVector.AfterConstruction;
begin
end;

procedure TJclIntfVector.BeforeDestruction;
begin
end;

//=== { TJclStrVector } ======================================================

constructor TJclStrVector.Create(ACapacity: Integer = DefaultContainerCapacity);
begin
  inherited Create;
  FCount := 0;
  if ACapacity < 0 then
    FCapacity := 0
  else
    FCapacity := ACapacity;
  SetLength(Items, FCapacity);
end;

destructor TJclStrVector.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TJclStrVector.Insert(Index: Integer; const AString: string);
begin
  if (Index < 0) or (Index > FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  System.Move(Items[Index], Items[Index - 1], (FCount - Index) * SizeOf(string));
  FCapacity := Length(Items);
  Items[Index] := AString;
  Inc(FCount);
end;

function TJclStrVector.Add(const AString: string): Boolean;
begin
  if FCount = FCapacity then
    Grow;
  Items[FCount] := AString;
  Inc(FCount);
  Result := True;
end;

function TJclStrVector.AddAll(ACollection: IJclStrCollection): Boolean;
var
  It: IJclStrIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    Add(It.Next);
  Result := True;
end;

function TJclStrVector.InsertAll(Index: Integer; ACollection: IJclStrCollection): Boolean;
var
  It: IJclStrIterator;
  Size: Integer;
begin
  Result := False;
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  if ACollection = nil then
    Exit;
  Size := ACollection.Size;
  System.Move(Items[Index], Items[Index + Size], Size * SizeOf(string));
  It := ACollection.First;
  while It.HasNext do
  begin
    Items[Index] := It.Next;
    Inc(Index);
  end;
  Result := True;
end;

procedure TJclStrVector.AfterConstruction;
begin
end;

procedure TJclStrVector.BeforeDestruction;
begin
end;

procedure TJclStrVector.Clear;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    Items[I] := '';
  FCount := 0;
end;

function TJclStrVector.Clone: TObject;
var
  NewList: TJclStrVector;
begin
  NewList := TJclStrVector.Create(FCapacity);
  NewList.AddAll(Self);
  Result := NewList;
end;

function TJclStrVector.Contains(const AString: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AString = '' then
    Exit;
  for I := 0 to FCount - 1 do
    if Items[I] = AString then
    begin
      Result := True;
      Break;
    end;
end;

function TJclStrVector.ContainsAll(ACollection: IJclStrCollection): Boolean;
var
  It: IJclStrIterator;
begin
  Result := True;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    if not Contains(It.Next) then
    begin
      Result := False;
      Break;
    end;
end;

function TJclStrVector.Equals(ACollection: IJclStrCollection): Boolean;
var
  I: Integer;
  It: IJclStrIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  if FCount <> ACollection.Size then
    Exit;
  It := ACollection.First;
  for I := 0 to FCount - 1 do
    if Items[I] <> It.Next then
      Exit;
  Result := True;
end;

function TJclStrVector.First: IJclStrIterator;
begin
  Result := TStrItr.Create(Self);
end;

function TJclStrVector.GetString(Index: Integer): string;
begin
  if (Index < 0) or (Index >= FCount) then
  begin
    Result := '';
    Exit;
  end;
  Result := Items[Index];
end;

procedure TJclStrVector.Grow;
begin
  if FCapacity > 64 then
    FCapacity := FCapacity + FCapacity div 4
  else
    FCapacity := FCapacity * 4;
  SetLength(Items, FCapacity);
end;

function TJclStrVector.IndexOf(const AString: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AString = '' then
    Exit;
  for I := 0 to FCount - 1 do
    if Items[I] = AString then
    begin
      Result := I;
      Exit;
    end;
end;

function TJclStrVector.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TJclStrVector.Last: IJclStrIterator;
var
  NewIterator: TStrItr;
begin
  NewIterator := TStrItr.Create(Self);
  NewIterator.FCursor := NewIterator.FOwnList.FCount;
  NewIterator.FSize := NewIterator.FOwnList.FCount;
  Result := NewIterator;
end;

function TJclStrVector.LastIndexOf(const AString: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AString = '' then
    Exit;
  for I := FCount - 1 downto 0 do
    if Items[I] = AString then
    begin
      Result := I;
      Break;
    end;
end;

function TJclStrVector.Remove(const AString: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AString = '' then
    Exit;
  for I := FCount - 1 downto 0 do
    if Items[I] = AString then // Removes all AString
    begin
      Items[I] := ''; // Force Release
      System.Move(Items[I + 1], Items[I], (FCount - I) * SizeOf(string));
      Dec(FCount);
      Result := True;
    end;
end;

function TJclStrVector.Remove(Index: Integer): string;
begin
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  Result := Items[Index];
  Items[Index] := '';
  System.Move(Items[Index + 1], Items[Index],
    (FCount - Index) * SizeOf(string));
  Dec(FCount);
end;

function TJclStrVector.RemoveAll(ACollection: IJclStrCollection): Boolean;
var
  It: IJclStrIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    Remove(It.Next);
end;

function TJclStrVector.RetainAll(ACollection: IJclStrCollection): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  for I := FCount - 1 downto 0 do
    if not ACollection.Contains(Items[I]) then
      Remove(I);
end;

procedure TJclStrVector.SetString(Index: Integer; const AString: string);
begin
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  Items[Index] := AString;
end;

function TJclStrVector.Size: Integer;
begin
  Result := FCount;
end;

function TJclStrVector.SubList(First, Count: Integer): IJclStrList;
var
  I: Integer;
  Last: Integer;
begin
  Last := First + Count - 1;
  if Last >= FCount then
    Last := FCount - 1;
  Result := TJclStrVector.Create(Count);
  for I := First to Last do
    Result.Add(Items[I]);
end;

//=== { TJclVector } =========================================================

constructor TJclVector.Create(ACapacity: Integer = DefaultContainerCapacity;
  AOwnsObjects: Boolean = True);
begin
  inherited Create;
  FCount := 0;
  FOwnsObjects := AOwnsObjects;
  if ACapacity < 0 then
    FCapacity := 0
  else
    FCapacity := ACapacity;
  SetLength(Items, FCapacity);
end;

destructor TJclVector.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TJclVector.Insert(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index > FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  System.Move(Items[Index], Items[Index - 1],
    (FCount - Index) * SizeOf(TObject));
  FCapacity := Length(Items);
  Items[Index] := AObject;
  Inc(FCount);
end;

function TJclVector.Add(AObject: TObject): Boolean;
begin
  if FCount = FCapacity then
    Grow;
  Items[FCount] := AObject;
  Inc(FCount);
  Result := True;
end;

function TJclVector.InsertAll(Index: Integer; ACollection: IJclCollection): Boolean;
var
  It: IJclIterator;
  Size: Integer;
begin
  Result := False;
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  if ACollection = nil then
    Exit;
  Size := ACollection.Size;
  System.Move(Items[Index], Items[Index + Size], Size * SizeOf(IInterface));
  It := ACollection.First;
  while It.HasNext do
  begin
    Items[Index] := It.Next;
    Inc(Index);
  end;
  Result := True;
end;

function TJclVector.AddAll(ACollection: IJclCollection): Boolean;
var
  It: IJclIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    Add(It.Next);
  Result := True;
end;

procedure TJclVector.Clear;
var
  I: Integer;
begin
  for I := 0 to FCount - 1 do
    FreeObject(Items[I]);
  FCount := 0;
end;

function TJclVector.Clone: TObject;
var
  NewList: TJclVector;
begin
  NewList := TJclVector.Create(FCapacity, False); // Only one can have FOwnsObject = True
  NewList.AddAll(Self);
  Result := NewList;
end;

function TJclVector.Contains(AObject: TObject): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AObject = nil then
    Exit;
  for I := 0 to FCount - 1 do
    if Items[I] = AObject then
    begin
      Result := True;
      Break;
    end;
end;

function TJclVector.ContainsAll(ACollection: IJclCollection): Boolean;
var
  It: IJclIterator;
begin
  Result := True;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    if not Contains(It.Next) then
    begin
      Result := False;
      Break;
    end;
end;

function TJclVector.Equals(ACollection: IJclCollection): Boolean;
var
  I: Integer;
  It: IJclIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  if FCount <> ACollection.Size then
    Exit;
  It := ACollection.First;
  for I := 0 to FCount - 1 do
    if Items[I] <> It.Next then
      Exit;
  Result := True;
end;

procedure TJclVector.FreeObject(var AObject: TObject);
begin
  if FOwnsObjects then
  begin
    AObject.Free;
    AObject := nil;
  end;
end;

function TJclVector.GetObject(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then
  begin
    Result := nil;
    Exit;
  end;
  Result := Items[Index];
end;

procedure TJclVector.Grow;
begin
  if FCapacity > 64 then
    FCapacity := FCapacity + FCapacity div 4
  else
    FCapacity := FCapacity * 4;
  SetLength(Items, FCapacity);
end;

function TJclVector.IndexOf(AObject: TObject): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AObject = nil then
    Exit;
  for I := 0 to FCount - 1 do
    if Items[I] = AObject then
    begin
      Result := I;
      Break;
    end;
end;

function TJclVector.First: IJclIterator;
begin
  Result := TItr.Create(Self);
end;

function TJclVector.IsEmpty: Boolean;
begin
  Result := FCount = 0;
end;

function TJclVector.Last: IJclIterator;
var
  NewIterator: TItr;
begin
  NewIterator := TItr.Create(Self);
  NewIterator.FCursor := NewIterator.FOwnList.FCount;
  NewIterator.FSize := NewIterator.FOwnList.FCount;
  Result := NewIterator;
end;

function TJclVector.LastIndexOf(AObject: TObject): Integer;
var
  I: Integer;
begin
  Result := -1;
  if AObject = nil then
    Exit;
  for I := FCount - 1 downto 0 do
    if Items[I] = AObject then
    begin
      Result := I;
      Break;
    end;
end;

function TJclVector.Remove(AObject: TObject): Boolean;
var
  I: Integer;
begin
  Result := False;
  if AObject = nil then
    Exit;
  for I := FCount - 1 downto 0 do
    if Items[I] = AObject then // Removes all AObject
    begin
      FreeObject(Items[I]);
      System.Move(Items[I + 1], Items[I], (FCount - I) * SizeOf(TObject));
      Dec(FCount);
      Result := True;
    end;
end;

function TJclVector.Remove(Index: Integer): TObject;
begin
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  Result := Items[Index];
  FreeObject(Items[Index]);
  System.Move(Items[Index + 1], Items[Index], (FCount - Index) * SizeOf(TObject));
  Dec(FCount);
end;

function TJclVector.RemoveAll(ACollection: IJclCollection): Boolean;
var
  It: IJclIterator;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  It := ACollection.First;
  while It.HasNext do
    Remove(It.Next);
end;

function TJclVector.RetainAll(ACollection: IJclCollection): Boolean;
var
  I: Integer;
begin
  Result := False;
  if ACollection = nil then
    Exit;
  for I := FCount - 1 to 0 do
    if not ACollection.Contains(Items[I]) then
      Remove(I);
end;

procedure TJclVector.SetObject(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (Index >= FCount) then
    raise EJclOutOfBoundsError.CreateResRec(@RsEOutOfBounds);
  Items[Index] := AObject;
end;

function TJclVector.Size: Integer;
begin
  Result := FCount;
end;

function TJclVector.SubList(First, Count: Integer): IJclList;
var
  I: Integer;
  Last: Integer;
begin
  Last := First + Count - 1;
  if Last >= FCount then
    Last := FCount - 1;
  Result := TJclVector.Create(Count, FOwnsObjects);
  for I := First to Last do
    Result.Add(Items[I]);
end;

procedure TJclVector.AfterConstruction;
begin
end;

procedure TJclVector.BeforeDestruction;
begin
end;

function TJclStrVector.GetAsStrings: TStrings;
begin
  Result := TStringList.Create;
  try
    AppendToStrings(Result);
  except
    Result.Free;
    raise;
  end;
end;

procedure TJclStrVector.LoadFromStrings(Strings: TStrings);
begin
  Clear;
  AppendFromStrings(Strings);
end;

procedure TJclStrVector.AppendToStrings(Strings: TStrings);
var
  It: IJclStrIterator;
begin
  It := First;
  Strings.BeginUpdate;
  try
    while It.HasNext do
      Strings.Add(It.Next);
  finally
    Strings.EndUpdate;
  end;
end;

procedure TJclStrVector.SaveToStrings(Strings: TStrings);
begin
  Strings.Clear;
  AppendToStrings(Strings);
end;

procedure TJclStrVector.AppendFromStrings(Strings: TStrings);
var
  I: Integer;
begin
  for I := 0 to Strings.Count - 1 do
    Add(Strings[I]);
end;

function TJclStrVector.GetAsDelimited(Separator: string): string;
var
  It: IJclStrIterator;
begin
  It := First;
  Result := '';
  if It.HasNext then
    Result := It.Next;
  while It.HasNext do
    Result := Result + Separator + It.Next;
end;

procedure TJclStrVector.AppendDelimited(AString, Separator: string);
begin
  DCLAppendDelimited(Self, AString, Separator);
end;

procedure TJclStrVector.LoadDelimited(AString, Separator: string);
begin
  Clear;
  AppendDelimited(AString, Separator);
end;

// History:

// $Log$
// Revision 1.4  2005/02/27 11:36:20  marquardt
// fixed and secured Capacity/Grow mechanism, raise exceptions with efficient CreateResRec
//
// Revision 1.3  2005/02/27 07:27:47  marquardt
// changed interface names from I to IJcl, moved resourcestrings to JclResource.pas
//
// Revision 1.2  2005/02/24 07:36:24  marquardt
// resolved the compiler warnings, style cleanup, removed code from JclContainerIntf.pas
//
// Revision 1.1  2005/02/24 03:57:10  rrossmair
// - donated DCL code, initial check-in
//

end.

