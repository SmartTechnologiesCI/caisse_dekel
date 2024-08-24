pageextension 70020 ArticlesStock extends 50018
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here


        addfirst(Processing)
        {
            action("Prix de vente")
            {
                Visible = profil = 'DIRECTEUR';
                ApplicationArea = Basic, Suite;
                Caption = 'Prix de vente';
                Image = Price;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Sales Prices";
                RunPageLink = "Item No." = field("No.");
            }
            action("Ajustement de stock")
            {
                Visible = profil = 'DIRECTEUR';
                ApplicationArea = Basic, Suite;
                Caption = 'Ajustement de Stock';
                Image = InventoryPick;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Ajustement: Record "Ajustement Stock";
                    xAjustement: Record "Ajustement Stock";
                    StockPar: record "Inventory Setup";
                    NoSeriesMgt: Codeunit NoSeriesManagement;
                begin
                    Ajustement.Reset();
                    xAjustement.Reset();
                    StockPar.Reset();
                    StockPar.GET;
                    if xAjustement.FindLast() then
                        NoSeriesMgt.InitSeries(StockPar."N° Ajustement", xAjustement."No. Series", 0D, Ajustement."No.", Ajustement."No. Series")
                    else
                        NoSeriesMgt.InitSeries(StockPar."N° Ajustement", Ajustement."No. Series", 0D, Ajustement."No.", Ajustement."No. Series");
                    Ajustement."Document Date" := WorkDate();
                    Ajustement."Item No." := rec."No.";
                    Ajustement.Description := rec.Description;
                    rec.CalcFields("Cartons Solde");
                    //rec.CalcFields("Cartons vendus");
                    Ajustement."curr Carton" := rec."Cartons Solde";
                    Ajustement."curr Quantity" := rec.Inventory;
                    //Ajustement."Location Code" := 'SIEGE';
                    Ajustement.Insert();
                    Ajustement.Reset();
                    Ajustement.SetRange("Item No.", rec."No.");
                    Ajustement.SetRange("Document Date", WorkDate());
                    if Ajustement.FindLast() then
                        Page.Run(Page::"Ajustement de stock", Ajustement);
                end;
            }
            action("AnnulerStock")
            {
                Visible = false;
                ApplicationArea = Basic, Suite;
                Caption = 'Annuler stock';
                Image = InventoryPick;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    item2: Record Item;
                begin
                    item2.Reset();
                    /* item2.CalcFields(Inventory);
                     item2.SetFilter(Inventory, '<0');
                     item2.SetFilter(Blocked, '=Non');*/


                    CurrPage.SetSelectionFilter(item2);
                    if item2.FindFirst() then begin
                        repeat
                        //remiseZERO(item2);
                        until item2.Next = 0;
                        Message('Terminé');
                    end else
                        Message('Aucun article');
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        prof: record "User Personalization";
    begin

        prof.Reset();
        prof.SetRange("User ID", UserId);
        if prof.FindFirst() then begin
            profil := prof."Profile ID";
        end;
    end;

    var
        profil: Code[50];
}