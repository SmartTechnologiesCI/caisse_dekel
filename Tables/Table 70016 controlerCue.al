table 70016 "ControllerCue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "codeTable"; Code[50]) { }
        field(2; "Non Payées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Non Payée"), "Document Date" = field(dateFilter), Cancelled = const(false)));
        }
        field(3; "Payées Non livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Payée non livré"), "Document Date" = field(dateFilter), Cancelled = const(false)));

        }
        field(4; "Payées partiellement livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Payée partiellement livré"), "Document Date" = field(dateFilter), Cancelled = const(false)));
        }
        field(5; "Payées totalement livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Payée totalement livré"), "Document Date" = field(dateFilter), Cancelled = const(false)));
        }
        /*field(6; "Non payées totalement livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("Non payée totalement livré"), "Document Date" = field(dateFilter), Cancelled=const(false)));

        }
        field(7; "Non payées partiel. livrées"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" Where("Statut Livraison" = const("non payée partiellement livré"), "Document Date" = field(dateFilter), Cancelled=const(false)));
        }*/
        field(8; dateFilter; date)
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "codeTable")
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