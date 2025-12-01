table 70003 "Parametres caisse"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; code[30])
        {
            Editable = false;
            InitValue = 'Par. Caisse';
        }
        field(3; "N° souche Mouvement"; code[30])
        {
            TableRelation = "No. Series";
        }
        field(4; "N° souche Ouverture"; code[30])
        {
            TableRelation = "No. Series";
        }
        field(5; "N° souche clôture"; code[30])
        {
            TableRelation = "No. Series";
        }
        field(6; "N° souche Depot"; code[30])
        {
            TableRelation = "No. Series";
        }
        field(7; "N° compte coffre fort"; code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(8; "N° compte banque virement"; code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(9; "N° compte banque cheque"; code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(10; "N° compte banque CB"; code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(11; "N° compte banque diverse"; code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(12; "N° compte caisse"; code[30])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(13; NumSouschPaie; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° paie Ticket';
            TableRelation = "No. Series";

        }
        field(14; PoucentageImpot; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Pourcentage Impôt';
            DecimalPlaces = 3;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
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