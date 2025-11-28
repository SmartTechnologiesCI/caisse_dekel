table 70029 Entete_Paiement
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; code_Paiement; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(50001; Palanteur_Transporteur; code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Planteur/Transporteur';
        }
        field(50002; Date_Paiement; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Beneficiare; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Caissier; Code[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Caissier/Caissière';
        }
    }

    keys
    {
        key(Key1; code_Paiement)
        {
            Clustered = true;
        }
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