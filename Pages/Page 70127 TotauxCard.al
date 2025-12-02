page 70127 TotauxCardPage
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Item Weigh Bridge";
    ModifyAllowed = true;
    InsertAllowed = true;

    layout
    {
        area(Content)
        {
            group(Paiement)
            {
                field(Poids_Total; REC.Poids_Total)
                {
                    ApplicationArea = All;
                }
                field(Impot; Impot)
                {
                    ApplicationArea = All;

                }

                field(Total; Total)
                {
                    ApplicationArea = All;
                    Caption = 'Total Achat Transporteur';
                    Editable = false;
                    Visible = false;
                }
                field(TotalPlanteur; TotalPlanteur)
                {
                    ApplicationArea = aLL;
                    Editable = false;
                }
                field(TotalPlanteurTTc; TotalPlanteurTTc)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(TotalTransPorteurTTC; TotalTransPorteurTTC)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
        }
        // area(Factboxes)
        // {

        // }
    }

    actions
    {
        // area(Processing)
        // {
        //     action(ActionName)
        //     {

        //         trigger OnAction()
        //         begin

        //         end;
        //     }
        // }
    }
}