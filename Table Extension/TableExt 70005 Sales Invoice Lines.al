tableextension 70005 "Sles Inv. Line" extends "Sales Invoice Line"
{
    fields
    {

        field(70009; "Statut Livraison"; Option)
        {
            OptionMembers = "Non payée","Non payée totalement livré","Non payée partiellement livré","Payée Non livré","Payée totalement livré","Payée partiellement livré";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Statut Livraison" = "Statut Livraison"::"Payée totalement livré" then
                    "Qté livrée" := "Carton effectif";
            end;
        }
        field(70010; "Qté livrée"; Integer)
        {
            Caption = 'Cartons livrés';
            /* trigger OnValidate()
            var
                myInt: Integer;
            begin

              if Confirm('La date de livraison sera modifiée ?',true) then begin
                  "Date Livraison" := WorkDate();
              end;

                if "Statut Livraison" = "Statut Livraison"::"Payée Non livré" then begin

                    if "Qté livrée" = "Carton effectif" then
                        "Statut Livraison" := "Statut Livraison"::"Payée totalement livré"
                    else
                        if "Qté livrée" < "Carton effectif" then
                            "Statut Livraison" := "Statut Livraison"::"Payée partiellement livré";
                end
                else
                    if "Statut Livraison" = "Statut Livraison"::"Non payée" then begin

                        if "Qté livrée" = "Carton effectif" then
                            "Statut Livraison" := "Statut Livraison"::"Non Payée totalement livré"
                        else
                            if "Qté livrée" < "Carton effectif" then
                                "Statut Livraison" := "Statut Livraison"::"Non Payée partiellement livré";
                    end;
            end; */
            FieldClass = FlowField;
            CalcFormula = sum("Controle Livraison"."Qté livrée" where("No facture" = field("Document No."), "No article" = field("No.")));

        }
        field(70011; "Date Livraison"; Date)
        {

        }

        field(70012; "Qté livrée auj"; Integer)
        {
            Caption = 'Cartons livrés aujourd''hui';
            FieldClass = FlowField;
            CalcFormula = sum("Controle Livraison"."Qté livrée" where("No facture" = field("Document No."), "No article" = field("No."), "Date Livraison" = field(datefilter)));

        }
        field(70013; datefilter; Date)
        {
            FieldClass = FlowFilter;

        }
        field(50008; "Preparateur"; Code[50])
        {

        }
        field(50009; "Verificateur"; Code[50])
        {

        }
        field(50001; "Code preparateur"; Code[50])
        {
            CaptionML = FRA = 'Code du préparateur';
            TableRelation = "User App".Nom;
        }
        field(50002; "Salesperson code"; Code[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup ("Sales Invoice Header"."Salesperson Code" where("No." = field("Document No.")));
           
        }

    }

    var

}