table 70027 "facturier Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; id; code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Factures du jour"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where("Order Date" = field("Date Filter"), "facturier" = const(false)));
        }
        field(3; "Factures anterieures"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where(Closed = const(false), "Order Date" = field("Date Filter 2"), "facturier" = const(false), "Statut Livraison" = const("Non payée")));
        }


        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }

        field(10; "date filter 2"; Date)
        {
            FieldClass = FlowFilter;
        }


    }


    keys
    {
        key(PK; id)
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