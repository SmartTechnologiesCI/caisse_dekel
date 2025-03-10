tableextension 70007 "Achat Activity Role Center Ext" extends 50008
{
    fields
    {
        // Add changes to table fields here
        field(7; "Factures douanieres"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Header" where("Est Echantillone" = const(true)));
            // silue samuel  CalcFormula = count("Sales Invoice Header" where("Est Echantillone" = const(true), "Due Date" = field(dateFilter)));

        }
        field(9; "Contrats payés"; Integer)
        {
            FieldClass = FlowField;
            // silue samuel 07/03/2025 CalcFormula = count("Purchase Header" where("Statut paiement" = const("Paid"), "Document Type" = const(Order)));
            CalcFormula = count("Purchase Header" where("Document Type" = const(Order)));
        }
    
        field(10; "Contrats Non payés"; Integer)
        {
            FieldClass = FlowField;
            // silue samuel 07/03/2025 CalcFormula = count("Purchase Header" where("Statut paiement" = const("Unpaid"), Avance = filter('<=0'), "Document Type" = const(Order)));
                        CalcFormula = count("Purchase Header" where("Document Type" = const(Order)));

        }
        field(11; "Contrats Partiellement payés"; Integer)
        {
            FieldClass = FlowField;
            // silue samuel 07/03/2025 CalcFormula = count("Purchase Header" where("Statut paiement" = const("Unpaid"), Avance = filter('>0'), "Document Type" = const(Order)));
                        CalcFormula = count("Purchase Header" where( "Document Type" = const(Order)));

        }
        field(8; dateFilter; date)
        {
            FieldClass = FlowFilter;
        }
    }

    var
        myInt: Integer;
}