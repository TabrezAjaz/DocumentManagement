codeunit 50145 CommonCodeunit
{
    Description = 'Author: TJ - First Release Version 1.0.02.04.2021';

    trigger OnRun()
    begin
    end;

    procedure InsertWebServiceLog(methodName: Text; methodType: Text; requestURL: Text; var recWebServiceLog: Record WebServiceLog; storeCode: Code[20])
    var
        entryNo: Integer;
        recWSLog: Record WebServiceLog;
    begin
        recWSLog.Reset();
        if recWSLog.FindLast() then
            entryNo := recWSLog.EntryNo + 1
        else
            entryNo := 1;
        recWebServiceLog.Reset();
        recWebServiceLog.Init();
        recWebServiceLog.EntryNo := entryNo;
        recWebServiceLog."Store Code" := storeCode;
        recWebServiceLog.ServiceName := methodName;
        recWebServiceLog.ServiceTypeMethod := methodType;
        recWebServiceLog.RequestTime := CurrentDateTime();
        recWebServiceLog.RequestedBy := UserId();
        recWebServiceLog.RequestUrl := requestUrl;
        recWebServiceLog.ResponseStatus := 'failed';
        recWebServiceLog.Insert();
        recWebServiceLog.FindLast();
    end;

    procedure UpdateWebServiceLog(var recWebServiceLog: Record WebServiceLog; NewResponse: Text)//; Method: Text; ServiceName: Text)
    var
        outStr: OutStream;
    begin
        recWebServiceLog.Response.CreateOutStream(outStr);
        outStr.WriteText(NewResponse);

        //recWebServiceLog.ServicesName := ServiceName;
        // recWebServiceLog.ServiceTypeMethod := Method;
        recWebServiceLog.ResponseStatus := 'Success';
        recWebServiceLog.ResponseTime := CurrentDateTime();
        recWebServiceLog.Modify();
    end;


    procedure AddHttpBasicAuthHeader1(YOURUSERNAME: Text; YOURPASSWORD: Text)
    var
        RequestMessage: HttpRequestMessage;
        Headers: HttpHeaders;
        base64Convert: Codeunit "Base64 Convert";
        AuthenticationString: Text;
    begin
        RequestMessage.GetHeaders(Headers);
        AuthenticationString := StrSubstNo('%1:%2', YOURUSERNAME, YOURPASSWORD);
        Headers.Add('Authorization', StrSubstNo('Basic %1', base64Convert.ToBase64(AuthenticationString)));
    end;

    procedure AddHttpBasicAuthHeader(UserName: Text[50]; Password: Text[50]; var HttpClient: HttpClient);
    var
        AuthString: Text;
        TypeHelper: Codeunit "Type Helper";
        cuCommon: Codeunit CommonCodeunit;
        base64Convert: Codeunit "Base64 Convert";
    begin
        AuthString := STRSUBSTNO('%1:%2', UserName, Password);
        //AuthString := base64Convert.ToBase64(AuthString);
        AuthString := cuCommon.TextToBase64String(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        HttpClient.DefaultRequestHeaders().Add('Authorization', AuthString);
    end;

    // Start: Base64Convert
    procedure TextToBase64String(Value: Text) ReturnValue: Text;
    var
        BinaryValue: text;
        Length: Integer;
    begin
        // Divide value into blocks of 3 bytes
        Length := StrLen(Value);
        BinaryValue := TextToBinary(Value, 8);
        ReturnValue := ConvertBinaryValueToBase64String(BinaryValue, Length);
    end;

    procedure StreamToBase64String(Value: InStream) ReturnValue: Text;
    var
        SingleByte: Byte;
        Length: Integer;
        BinaryValue: Text;
    begin
        while not Value.EOS do begin
            Value.Read(SingleByte, 1);
            Length += 1;
            BinaryValue += ByteToBinary(SingleByte, 8);
        end;
        ReturnValue := ConvertBinaryValueToBase64String(BinaryValue, Length);
    end;

    procedure FromBase64StringToText(Value: Text) ReturnValue: Text;
    var
        BinaryValue: Text;
    begin
        BinaryValue := ConvertBase64StringToBinaryValue(Value);
        ReturnValue := BinaryToText(BinaryValue);
    end;

    procedure FromBase64StringToStream(Value: Text;
    var ReturnValue: OutStream);
    var
        BinaryValue: Text;
    begin
        BinaryValue := ConvertBase64StringToBinaryValue(Value);
        BinaryToStream(BinaryValue, ReturnValue);
    end;

    local procedure ConvertBinaryValueToBase64String(Value: Text;
    Length: Integer) ReturnValue: Text;
    var
        Length2: Integer;
        PaddingCount: Integer;
        BlockCount: Integer;
        Pos: Integer;
        CurrentByte: text;
        i: Integer;
    begin
        if Length MOD 3 = 0 then begin
            PaddingCount := 0;
            BlockCount := Length / 3;
        end
        else begin
            PaddingCount := 3 - (Length MOD 3);
            BlockCount := (Length + PaddingCount) / 3;
        end;
        Length2 := Length + PaddingCount;
        Value := PadStr(Value, Length2 * 8, '0');
        // Loop through bytes in groups of 6 bits
        Pos := 1;
        while Pos < Length2 * 8 do begin
            CurrentByte := CopyStr(Value, Pos, 6);
            ReturnValue += GetBase64Char(BinaryToInt(CurrentByte));
            pos += 6;
        end;
        // Replace last characters with '='
        for i := 1 to PaddingCount do begin
            Pos := StrLen(ReturnValue) - i + 1;
            ReturnValue[Pos] := '=';
        end;
    end;

    local procedure ConvertBase64StringToBinaryValue(Value: Text) ReturnValue: Text;
    var
        BinaryValue: Text;
        i: Integer;
        IntValue: Integer;
        PaddingCount: Integer;
    begin
        for i := 1 to StrLen(Value) do begin
            if Value[i] = '=' then PaddingCount += 1;
            IntValue := GetBase64Number(Value[i]);
            BinaryValue += IncreaseStringLength(IntToBinary(IntValue), 6);
        end;
        for i := 1 to PaddingCount do BinaryValue := CopyStr(BinaryValue, 1, StrLen(BinaryValue) - 8);
        ReturnValue := BinaryValue;
    end;

    local procedure TextToBinary(Value: text;
    ByteLength: Integer) ReturnValue: text;
    var
        IntValue: Integer;
        i: Integer;
        BinaryValue: text;
    begin
        for i := 1 to StrLen(value) do begin
            IntValue := value[i];
            BinaryValue := IntToBinary(IntValue);
            BinaryValue := IncreaseStringLength(BinaryValue, ByteLength);
            ReturnValue += BinaryValue;
        end;
    end;

    local procedure BinaryToText(Value: Text) ReturnValue: Text;
    var
        Buffer: BigText;
        Pos: Integer;
        SingleByte: Text;
        CharValue: Text;
    begin
        Buffer.AddText(Value);
        Pos := 1;
        while Pos < Buffer.Length do begin
            Buffer.GetSubText(SingleByte, Pos, 8);
            CharValue[1] := BinaryToInt(SingleByte);
            ReturnValue += CharValue;
            Pos += 8;
        end;
    end;

    local procedure BinaryToStream(Value: Text;
    var ReturnValue: OutStream);
    var
        Buffer: BigText;
        Pos: Integer;
        SingleByte: Text;
        ByteValue: Byte;
    begin
        Buffer.AddText(Value);
        Pos := 1;
        while Pos < Buffer.Length do begin
            Buffer.GetSubText(SingleByte, Pos, 8);
            ByteValue := BinaryToInt(SingleByte);
            ReturnValue.Write(ByteValue, 1);
            Pos += 8;
        end;
    end;

    local procedure ByteToBinary(Value: Byte;
    ByteLenght: Integer) ReturnValue: Text;
    var
        BinaryValue: Text;
    begin
        BinaryValue := IntToBinary(Value);
        BinaryValue := IncreaseStringLength(BinaryValue, ByteLenght);
        ReturnValue := BinaryValue;
    end;

    local procedure IntToBinary(Value: integer) ReturnValue: text;
    begin
        while Value >= 1 do begin
            ReturnValue := Format(Value MOD 2) + ReturnValue;
            Value := Value DIV 2;
        end;
    end;

    local procedure BinaryToInt(Value: Text) ReturnValue: Integer;
    var
        Multiplier: BigInteger;
        IntValue: Integer;
        i: Integer;
    begin
        Multiplier := 1;
        for i := StrLen(Value) downto 1 do begin
            Evaluate(IntValue, CopyStr(Value, i, 1));
            ReturnValue += IntValue * Multiplier;
            Multiplier *= 2;
        end;
    end;

    local procedure IncreaseStringLength(Value: Text;
    ToLength: Integer) ReturnValue: Text;
    var
        ExtraLength: Integer;
        ExtraText: Text;
    begin
        ExtraLength := ToLength - StrLen(Value);
        if ExtraLength < 0 then exit;
        ExtraText := PadStr(ExtraText, ExtraLength, '0');
        ReturnValue := ExtraText + Value;
    end;

    local procedure GetBase64Char(Value: Integer): text;
    var
        chars: text;
        i: Integer;
    begin
        chars := Base64Chars;
        exit(chars[Value + 1]);
    end;

    local procedure GetBase64Number(Value: text): Integer;
    var
        chars: text;
    begin
        if Value = '=' then exit(0);
        chars := Base64Chars;
        exit(StrPos(chars, Value) - 1);
    end;

    local procedure Base64Chars(): text;
    begin
        exit('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/');
    end;
    // Stop: Base64Convert
    var
        myInt: Integer;
}
