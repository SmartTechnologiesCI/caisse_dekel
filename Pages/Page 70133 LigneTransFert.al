page 70133 LigneTransFert
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = LigneTransFert;

    layout
    {
        area(Content)
        {
            repeater(Ligne)
            {
                Caption = 'Lignes Transfert';
                field(IDLIGNETRANSFERT; IDLIGNETRANSFERT)
                {
                
                }
                field(NumDocExtern; NumDocExtern)
                {
                    ApplicationArea = All;
                }
                field(caisse; caisse)
                {
                    ApplicationArea = All;
                }
                field(Montant; Montant)
                {
                    ApplicationArea = All;
                }
                field(ModeReglement; ModeReglement)
                {
                    ApplicationArea = All;
                }
                
            }
        }


    }

    actions
    {
        area(Processing)
        {
            // action(ActionName)
            // {

            //     trigger OnAction()
            //     begin

            //     end;
            // }
        }
    }
}