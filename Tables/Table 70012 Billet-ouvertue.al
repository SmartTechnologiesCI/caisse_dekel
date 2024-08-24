table 70012 "Billiet ouverture"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "N° ouverture"; code[20])
        {
            TableRelation = "Ouverture de caisse".No;
        }
        field(2; "Code Caisse"; code[20])
        {
            TableRelation = "Caisse"."Code caisse";
        }
        field(3; "Code Billet"; code[20])
        {
            TableRelation = Billetage."Code Billet";
        }
        field(7; "date"; Date)
        {

        }
        field(4; "Qty."; integer)
        {

        }
        field(5; "Start"; Boolean)
        {

        }
        field(6; "Total"; Decimal)
        {

        }
    }



    keys
    {
        key(PK; "N° ouverture","Code Caisse","Code Billet")
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