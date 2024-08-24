tableextension 70003 "Item" extends Item
{
    fields
    {
        field(70000; "Nombre cartons"; Integer)
        {
            //FieldClass = FlowField;
            //CalcFormula = sum(Pesse.nombre where("No." = field("No."), Valid = const(true)));
            //CalcFormula = sum(Pesse.nombre where("No." = field("No."), Valid = const(true), verif = const(false), facture = const(true)));
        }
        field(70004; "Nombre cartons2"; Integer)
        {
            FieldClass = FlowField;
            //CalcFormula = sum(Pesse.nombre where("No." = field("No."), Valid = const(true)));
            CalcFormula = sum(Pesse.nombre where("No." = field("No."), Valid = const(true), verif = const(false), facture = const(true), SystemCreatedAt = field(DateFilter2)));
        }

        field(70005; "Poids"; Decimal)
        {
            FieldClass = FlowField;
            //CalcFormula = sum(Pesse.nombre where("No." = field("No."), Valid = const(true)));
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                  "Posting Date" = field(DateFilter)
                                                                  )

            );
        }

        field(70006; "DateFilter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(70007; "DateFilter2"; DateTime)
        {
            FieldClass = FlowFilter;
        }

        field(70001; "Carton commande"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Invoice Line"."Carton effectif" where("No." = field("No."), "Posting Date" = filter('>01/07/2021')));
        }
        field(70002; "Carton livre"; Integer)
        {
            FieldClass = FlowField;
            //CalcFormula = sum("Sales Invoice Line"."Qté livrée" where("No." = field("No.")));
            CalcFormula = sum("Controle Livraison"."Qté livrée" where("No article" = field("No."), "Date Livraison" = filter('>01/07/2021')));
        }
        field(70003; "Statut Livraison"; Boolean)
        {
            CalcFormula = exist("Sales Invoice Line" where("Statut Livraison" = filter('=Payée Non livré|Payée partiellement livré'), "No." = field("No.")));

            FieldClass = FlowField;

            /*           field(70009; "Statut Livraison"; Option)
                 {
                     OptionMembers = "Non payée","Non payée totalement livré","Non payée partiellement livré","Payée Non livré","Payée totalement livré","Payée partiellement livré";
                     trigger OnValidate()
                     var
                         myInt: Integer;
                     begin
                         if "Statut Livraison" = "Statut Livraison"::"Payée totalement livré" then
                             "Qté livrée" := "Carton effectif";
                     end;
                 } */

        }


    }

    var
        myInt: Integer;
}