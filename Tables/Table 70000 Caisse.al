table 70010 Caisse
{
    // DataCaptionFields = "Code caisse", "Nom caisse";
    fields
    {
        field(1; "Code caisse"; Code[30])
        {
            CaptionML = ENU = 'Cash register code', FRA = 'Code caisse';
        }
        field(2; "Nom caisse"; Text[50])
        {
            CaptionML = ENU = 'Cash register name', FRA = 'Nom caisse';
        }
        field(3; "User ID"; Text[50])
        {
            CaptionML = ENU = 'User Name', FRA = 'Utilisateur';
            TableRelation = "User Setup"."User ID";
        }
        field(4; "Compte"; Text[50])
        {
            CaptionML = ENU = 'Account N°', FRA = 'N° Compte comptable';
            TableRelation = "Bank Account"."No.";
        }
        field(5; "caisse No souche"; Text[50])
        {
            CaptionML = ENU = 'Point N*°', FRA = 'Point de caisse N° de souche';
            TableRelation = "No. Series";
        }
        field(6; "E/S No souche"; Text[50])
        {
            CaptionML = ENU = 'Exception Incomes/outcomes N°', FRA = 'Mouvements HAO N° de souche';
            TableRelation = "No. Series";
        }
        field(7; "Total"; Decimal)
        {
            CaptionML = ENU = 'Theoric amount in cash register', FRA = 'Point de caisse théorique';
        }
        field(8; "Total2"; Decimal)
        {
            CaptionML = ENU = 'Declared amount in cash register', FRA = 'Point de caisse déclaré';
        }
        field(9; "Difference"; Decimal)
        {
            CaptionML = ENU = 'Difference', FRA = 'Différence';
        }
        field(10; Solde; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(Transactions."Montant NET" where("Code caisse" = field("Code caisse")));
        }
        // field(11; Utilissateir; Text[250])
        // {
        //     FieldClass = FlowFilter;

        // }
    }

    keys
    {
        key(PK; "Code caisse")
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