tableextension 70027 "Purchase Cue" extends "Purchase Cue"
{
    fields
    {
        field(60000; "Ticket du jour"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 3"), Valide = const(true), "Statut paiement" = const(false)));
        }
        field(60001; "date filter 3"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(60002; "date filter 2"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(60003; "Ticke Anterieur non paye"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 2"), Valide = const(true), "Statut paiement" = const(false)));
        }
        field(60004; "Ticket(s) Facturé(s) du jour"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Item Weigh Bridge" where("Date validation" = field("date filter 3"), "Statut paiement" = const(true)));

        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}