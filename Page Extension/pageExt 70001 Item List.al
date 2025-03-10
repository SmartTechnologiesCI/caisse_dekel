pageextension 70001 "Item List" extends "Item List"
{
    layout
    {
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Unit Cost")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        /* modify(InventoryField)
         {
           //  Visible = false;
         }*/

        modify("Search Description")
        {
            Visible = false;
        }
        addafter(Description)
        {
            /*field("Nombre cartons"; stock)
            {
                Visible = false;
                ApplicationArea = All;
            }
            field(cartons; rec."Nombre cartons")
            {
                Visible = tlp;
                caption = 'Nombre cartons';
            }*/

            // field(cartonsSolde; rec."Cartons Solde")
            // {
            //     caption = 'Nombre de carton';
            // }
        }

    }

    actions
    {        // Add changes to page actions here
        modify("Price List")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                Report.Run(70004, true, false);
                exit;
            end;
        }
        addfirst(Item)
        {
            action("Ajustement de stock")
            {
                ApplicationArea = All;
                Caption = 'Ajustemeant de Stock';
                Image = InventoryPick;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Category6;
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
                        // NoSeriesMgt.InitSeries(StockPar."N° Ajustement", xAjustement."No. Series", 0D, Ajustement."No.", Ajustement."No. Series")
                    // else
                        // NoSeriesMgt.InitSeries(StockPar."N° Ajustement", Ajustement."No. Series", 0D, Ajustement."No.", Ajustement."No. Series");
                    Ajustement."Document Date" := WorkDate();
                    Ajustement."Item No." := rec."No.";
                    Ajustement.Description := rec.Description;
                    // rec.CalcFields("Cartons Solde");
                    // rec.CalcFields("Cartons vendus");
                    // Ajustement."curr Carton" := rec."Cartons Solde";
                    Ajustement."curr Quantity" := rec.Inventory;
                    //Ajustement."Location Code" := '';
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
                ApplicationArea = All;
                Caption = 'Annuler le stock';
                Image = InventoryPick;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Category6;
                Visible = true; //Smart olivier
                trigger OnAction()
                var
                    // silue samuel 07/03/2025article: Record Item;
                    "ItemJournal": record 83;
                    i: integer;
                    J: integer;
                    //silue samuel 07/03/2025 articl: Record Item;
                begin
                    // article.Reset();
                    // article.CalcFields(Inventory);
                    // article.SetFilter(Inventory, '<0');
                    // article.SetRange(Blocked, false);
                    // if article.FindFirst() then begin
                    //     repeat

                    //         article.CalcFields(Inventory);
                    //         IF article.Inventory > 0 then begin
                    //             clear(ItemJournal);
                    //             ItemJournal.Reset();
                    //             ItemJournal."Posting Date" := WorkDate();
                    //             ItemJournal."Document No." := 'T00' + Format(J);
                    //             ItemJournal."Line No." := i;
                    //             ItemJournal."Journal Template Name" := 'ARTICLE';
                    //             ItemJournal."Journal Batch Name" := 'DEFAUT';
                    //             ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Negative Adjmt.";
                    //             ItemJournal."Item No." := article."No.";
                    //             ItemJournal.Validate("Item No.");
                    //             articl.Reset();
                    //             articl.SetRange("No.", article."No.");
                    //             if articl.FindFirst() then begin
                    //                 itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";


                    //             end;
                    //             itemJournal.Validate("Gen. Prod. Posting Group");
                    //             //  ItemJournal."Location Code" := 'SIEGE';
                    //             ItemJournal.Quantity := article.Inventory;
                    //             ItemJournal.Validate(Quantity);
                    //             ItemJournal.Insert();
                    //             i += 10000;
                    //             J += 1;
                    //         end else
                    //             IF article.Inventory < 0 then begin
                    //                 ItemJournal.Reset();
                    //                 ItemJournal.Init();
                    //                 ItemJournal."Posting Date" := WorkDate();
                    //                 ItemJournal."Document No." := 'T00' + Format(J);
                    //                 ItemJournal."Line No." := i;
                    //                 ItemJournal."Journal Template Name" := 'ARTICLE';
                    //                 ItemJournal."Journal Batch Name" := 'DEFAUT';
                    //                 ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Positive Adjmt.";
                    //                 ItemJournal."Item No." := article."No.";
                    //                 ItemJournal.Validate("Item No.");

                    //                 articl.Reset();
                    //                 articl.SetRange("No.", article."No.");
                    //                 if articl.FindFirst() then begin
                    //                     itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";

                    //                 end;
                    //                 itemJournal.Validate("Gen. Prod. Posting Group");
                    //                 //  ItemJournal."Location Code" := 'SIEGE';
                    //                 ItemJournal.Quantity := -article.Inventory;
                    //                 ItemJournal.Validate(Quantity);
                    //                 ItemJournal.Insert();
                    //                 i += 10000;
                    //                 J += 1;
                    //             end;
                    //     until article.Next = 0;
                    //     Message('Terminé');
                    // end else
                    //   silue samuel 07/03/2025  Message('Aucun article');
                end;
            }
            //<---Smart Fabrice
            action("Annuler Stock2")
            {
                ApplicationArea = All;
                Caption = 'Annuler le stock2';
                Image = InventoryPick;
                Scope = Repeater;
                Promoted = true;
                PromotedCategory = Category6;
                Visible = true;

                trigger OnAction()
                var
                    AnnulStockNegatif: Codeunit "Annuler Stock Negatif";
                begin
                    AnnulStockNegatif.Run()
                end;
            }
            //
        }
        addafter("Item Journal")
        {
            action(remiseAZ)
            {
                Promoted = true;
                Scope = Repeater;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    RemiseAZero();
                end;
            }
        }
    }


    /*trigger OnAfterGetRecord()
    var
        article: record Item;
    begin
        rec.SetCurrentKey(Description);
        article.Reset();
        if article.FindFirst() then begin
            repeat
                article.CalcFields("Cartons achetés");
                article.CalcFields("Cartons vendus");
                achetes := -article."Cartons achetés";
                vendu := article."Cartons vendus";
                stock := -(article."Cartons achetés" + article."Cartons vendus");
                //article."Nombre cartons" := stock;
                //if stock < 0 then stock := 0;
                article.Modify();
            until article.Next = 0;
        end;

        rec.CalcFields(Rec."Cartons vendus");
        rec.CalcFields(Rec."Cartons achetés");

        NbCartons := -(Rec."Cartons achetés" + Rec."Cartons vendus");


        // rec.Modify();
    end;*/

    trigger OnOpenPage()
    var
        //silue samuel 07/03/2025 article: record Item;
        userPerso: record "User Personalization";
        //silue samuel 07/03/2025 articl: record Item;
    begin
        rec.SetRange(Blocked, false);
        rec.SetCurrentKey(Description);
        rec.SetAscending(Description, true);
        /*article.Reset();
        article.SetRange(Blocked, false);
        if article.FindFirst() then begin
            repeat
                article.CalcFields("Cartons achetés");
                article.CalcFields("Cartons vendus");
                achetes := -article."Cartons achetés";
                vendu := article."Cartons vendus";
                stock := -(article."Cartons achetés" + article."Cartons vendus");
                article."Nombre cartons" := stock;
                //if stock < 0 then stock := 0;
                article.Modify();
            until article.Next = 0;
        end;*/
        if UserId = 'TULIPE' then
            tlp := true
        else
            tlp := false;
    end;

    // local procedure remiseZERO(article: record Item)
    // var
    //     "ItemJournal": record 83;
    //     i: integer;
    //     J: integer;
    //     //silue samuel 07/03/2025 articl: record Item;
    // begin
    //     repeat
    //         article.CalcFields(Inventory);
    //         IF article.Inventory > 0 then begin
    //             clear(ItemJournal);
    //             ItemJournal.Reset();
    //             ItemJournal."Posting Date" := WorkDate();
    //             ItemJournal."Document No." := 'T00' + Format(J);
    //             ItemJournal."Line No." := i;
    //             ItemJournal."Journal Template Name" := 'ARTICLE';
    //             ItemJournal."Journal Batch Name" := 'DEFAUT';
    //             ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Negative Adjmt.";
    //             ItemJournal."Item No." := article."No.";
    //             ItemJournal.Validate("Item No.");
    //             // articl.Reset();
    //             // articl.SetRange("No.", article."No.");
    //             // if articl.FindFirst() then begin
    //             //     itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";

    //             end;
    //             itemJournal.Validate("Gen. Prod. Posting Group");
    //             //   ItemJournal."Location Code" := 'SIEGE';
    //             ItemJournal.Quantity := article.Inventory;
    //             ItemJournal.Validate(Quantity);
    //             ItemJournal.Insert();
    //             i += 10000;
    //             J += 1;
    //         // end else
    //             IF article.Inventory < 0 then begin
    //                 ItemJournal.Reset();
    //                 ItemJournal.Init();
    //                 ItemJournal."Posting Date" := WorkDate();
    //                 ItemJournal."Document No." := 'T00' + Format(J);
    //                 ItemJournal."Line No." := i;
    //                 ItemJournal."Journal Template Name" := 'ARTICLE';
    //                 ItemJournal."Journal Batch Name" := 'DEFAUT';
    //                 ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Positive Adjmt.";
    //                 ItemJournal."Item No." := article."No.";
    //                 ItemJournal.Validate("Item No.");
    //                 // articl.Reset();
    //                 // articl.SetRange("No.", article."No.");
    //                 // if articl.FindFirst() then begin
    //                 //     itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";

    //                 // end;
    //                 itemJournal.Validate("Gen. Prod. Posting Group");
    //                 //  ItemJournal."Location Code" := 'SIEGE';
    //                 ItemJournal.Quantity := -article.Inventory;
    //                 ItemJournal.Validate(Quantity);
    //                 ItemJournal.Insert();
    //                 i += 10000;
    //                 J += 1;
    //             end;
    //     until article.Next = 0;
    // end;

    local procedure RemiseAZero()
    var
        // article: record Item;
        "ItemJournal": record 83;
        i: integer;
        J: integer;
        // articl: record Item;
    begin
        //rec.SetCurrentKey(Description);
        i := 10000;
        J := 386;
        // article.Reset();
        // CurrPage.SetSelectionFilter(article);
        // if article.FindFirst() then begin
        //     repeat
        //         article.CalcFields(Inventory);
        //         IF article.Inventory > 0 then begin
        //             clear(ItemJournal);
        //             ItemJournal.Reset();
        //             ItemJournal."Posting Date" := WorkDate();
        //             ItemJournal."Document No." := 'T00' + Format(J);
        //             ItemJournal."Line No." := i;
        //             ItemJournal."Journal Template Name" := 'ARTICLE';
        //             ItemJournal."Journal Batch Name" := 'DEFAUT';
        //             ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Negative Adjmt.";
        //             ItemJournal."Item No." := article."No.";
        //             ItemJournal.Validate("Item No.");
        //             articl.Reset();
        //             articl.SetRange("No.", article."No.");
        //             if articl.FindFirst() then begin
        //                 itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";

        //             end;
        //             itemJournal.Validate("Gen. Prod. Posting Group");
        //             //   ItemJournal."Location Code" := 'SIEGE';
        //             ItemJournal.Quantity := article.Inventory;
        //             ItemJournal.Validate(Quantity);
        //             ItemJournal.Insert();
        //             i += 10000;
        //             J += 1;
        //         end else
        //             IF article.Inventory < 0 then begin
        //                 ItemJournal.Reset();
        //                 ItemJournal.Init();
        //                 ItemJournal."Posting Date" := WorkDate();
        //                 ItemJournal."Document No." := 'T00' + Format(J);
        //                 ItemJournal."Line No." := i;
        //                 ItemJournal."Journal Template Name" := 'ARTICLE';
        //                 ItemJournal."Journal Batch Name" := 'DEFAUT';
        //                 ItemJournal."Entry Type" := ItemJournal."Entry Type"::"Positive Adjmt.";
        //                 ItemJournal."Item No." := article."No.";
        //                 ItemJournal.Validate("Item No.");
        //                 articl.Reset();
        //                 articl.SetRange("No.", article."No.");
        //                 if articl.FindFirst() then begin
        //                     itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";

        //                 end;
        //                 itemJournal.Validate("Gen. Prod. Posting Group");
        //                 //       ItemJournal."Location Code" := 'SIEGE';
        //                 ItemJournal.Quantity := -article.Inventory;
        //                 ItemJournal.Validate(Quantity);
        //                 ItemJournal.Insert();
        //                 i += 10000;
        //                 J += 1;
        //             end;
        //     until article.Next = 0;
        // silue samuel 07/03/2025 End;
    End;

    var
        achetes: Integer;
        vendu: Integer;
        stock: Integer;
        NbCartons: Integer;
        tlp: Boolean;
}