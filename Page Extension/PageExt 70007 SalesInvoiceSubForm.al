pageextension 70007 "SalesInvSubF" extends 133
{
    Editable = true;
    layout
    {
        modify(Type)
        {
            Editable = false;
        }
        modify("No.")
        {
            Editable = false;
        }
        modify(Description)
        {
            Editable = false;
        }
        modify("Nombre de carton")
        {
            Editable = false;
        }
        modify(Quantity)
        {
            Editable = false;
        }
        modify("Unit Price")
        {
            Editable = false;
        }
        modify("Unit of Measure")
        {
            Editable = false;
        }
        modify("Unit of Measure Code")
        {
            Editable = false;
        }
        modify("Line Amount")
        {
            Editable = false;
        }
        modify("Line Discount %")
        {
            Editable = false;
        }
        modify("Deferral Code")
        {
            Editable = false;
        }
        addafter("Line Amount")
        {
            field("Statut Livraison"; rec."Statut Livraison")
            {

            }
            field("Qté livrée"; rec."Qté livrée")
            {

            }
            field("Marge unitaire"; rec."Marge unitaire")
            {
                ApplicationArea = All;
            }
            field("Salesperson code"; rec."Salesperson code")
            {
                Visible = false;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}