table 70001 "Billetage"
{


    fields
    {
        field(1; "Code Billet"; code[20])
        {

        }
        field(2; "Nom Billet"; Text[50])
        {

        }
        field(3; "Valeur"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Code Billet")
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