table 70019 "Controle Livraison"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "No"; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "No article"; Code[20])
        {

        }
        field(3; "No facture"; Code[20]) { }


        field(5; "Date Livraison"; Date) { }
        field(8; dateFilter; date)
        {
            FieldClass = FlowFilter;
        }
        field(9; "Qté livrée"; Integer) { }
        field(10; "Statut Livraison"; Text[100]) { }
    }

    keys
    {
        key(Key1; "No")
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