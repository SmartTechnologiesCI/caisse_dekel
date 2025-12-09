table 70034 LigneTransFert
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; IDLIGNETRANSFERT; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;

        }
        field(50001; caisse; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Caisse."Code caisse";
        }
        field(50002; Montant; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; NumDocExtern; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° Doc Externe';
        }
        field(50004; ModeReglement; Option)
        {
            Caption = 'Mode règlement';
            OptionMembers = ESPECE,WAVE,OM,"MTN Money","MOOV Money",CHEQUE;
        }
        field(50005; CodAuto; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; IDLIGNETRANSFERT, NumDocExtern,CodAuto)
        {
            Clustered = true;
        }
        // key(MyKey2; CodAuto)
        // {

        // }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}