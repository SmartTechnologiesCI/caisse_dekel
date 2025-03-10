page 70066 "Ajustement de stock"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 70018;

    layout
    {
        area(Content)
        {
            group("Général")
            {
                field("No."; rec."No.")
                {
                    Caption = 'N°';
                }
                field("Document Date"; rec."Document Date")
                {
                    Editable = false;
                    Caption = 'Date de document';
                }
                field("Posting Date"; rec."Posting Date")
                {
                    Editable = false;
                    Caption = 'Date de comptabilisation';
                }
            }
            group("Article")
            {
                field("Item No."; rec."Item No.")
                {
                    Caption = 'N° Article';
                    trigger OnValidate()
                    var
                        // item: record Item;
                        achetes: Integer;
                        vendu: Integer;
                        stock: Integer;
                    begin
                        //silue samuel 07/03/2025 item.SetRange(loc, '%1', rec."Location Code");
                        // item.SetRange("No.", rec."Item No.");
                        // if item.FindFirst() then begin
                        //     item.CalcFields("Cartons achetés");
                        //     item.CalcFields("Cartons vendus");
                        //     achetes := -item."Cartons achetés";
                        //     vendu := item."Cartons vendus";
                        //     stock := -(item."Cartons achetés" + item."Cartons vendus");
                        //     item."Nombre cartons" := stock;
                        //     rec.Description := item.Description;
                        //     item.CalcFields("Cartons Solde");
                        //     rec."curr Carton" := item."Cartons Solde";
                        //     item.CalcFields(Inventory);
                        //     rec."curr Quantity" := item.Inventory;
                        //     rec."curr Carton Mag" := item.ItemCartonStokbyMagasin2(rec."Location Code");
                        //     rec."curr Quantity Mag" := item.ItemQuantityStockbyMagasin(rec."Location Code");
                        // end;
                    end;


                }
                field(Description; rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                }
                field("curr Carton"; rec."curr Carton")
                {
                    Caption = 'Cartons total';
                    Style = Favorable;
                }
                field("curr Quantity"; rec."curr Quantity")
                {
                    Caption = 'Quantité total';
                    Style = Favorable;
                    DecimalPlaces = 0 : 3;
                }
                field("Location Code"; rec."Location Code")
                {
                    Caption = 'Code magasin';
                    ShowMandatory = true;
                    Style = Unfavorable;


                    trigger OnValidate()
                    var
                        // item: record Item;
                        achetes: Integer;
                        vendu: Integer;
                        stock: Integer;
                    begin
                        // item.SetRange(loc, '%1', rec."Location Code");
                        //silue samuel 07/03/2025 item.SetRange("No.", rec."Item No.");
                        // if item.FindFirst() then begin
                        //     item.CalcFields("Cartons achetés");
                        //     item.CalcFields("Cartons vendus");
                        //     achetes := -item."Cartons achetés";
                        //     vendu := item."Cartons vendus";
                        //     stock := -(item."Cartons achetés" + item."Cartons vendus");
                        //     item."Nombre cartons" := stock;
                        //     rec.Description := item.Description;
                        //     item.CalcFields("Cartons Solde");
                        //     rec."curr Carton" := item."Cartons Solde";
                        //     item.CalcFields(Inventory);
                        //     rec."curr Quantity" := item.Inventory;
                        //     rec."curr Carton Mag" := item.ItemCartonStokbyMagasin2(rec."Location Code");
                        //     rec."curr Quantity Mag" := item.ItemQuantityStockbyMagasin(rec."Location Code");
                        // end;
                    end;

                }
                field("curr Carton Mag"; rec."curr Carton Mag")
                {
                    // Caption = 'Cartons total';
                    Style = Strong;
                }
                field("curr Quantity Mag"; rec."curr Quantity Mag")
                {
                    // Caption = 'Quantité total';
                    Style = Strong;
                    DecimalPlaces = 0 : 3;
                }

            }
            group("Ajustement")
            {
                field(Type; rec.Type)
                {
                    Caption = 'Type';
                }

                // field("Nombre Cartons"; rec."Nombre Cartons")// carton ajustement
                // {
                //     Caption = 'Nombre de cartons'; //Style =
                //     BlankZero = true;
                // }
                field("Quantité"; rec."Quantité") // Qutantité ajustement
                {
                    DecimalPlaces = 0 : 3;
                    Caption = 'Poids';
                    BlankZero = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Valider Ajustement")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = PostDocument;
                Enabled = NOT rec.Posted;
                trigger OnAction()
                var
                    itemJournal: record 83;
                    xitemJournal: record 83;
                    yitemJournal: record 83;
                    //  silue samuel 07/03/2025pesée: Record Pesse;
                    //   silue samuel 07/03/2025
                    // ecritureCarton: record "Ecriture cartons articles";
                    // ecritureCarton2: record "Ecriture cartons articles";
                    // silue samuel 07/03/2025articl: Record Item;
                    // ItemLedger: Record "Item Ledger Entry";
                begin
                    if not yitemJournal.IsEmpty() then begin
                        yitemJournal.DeleteAll();
                        yitemJournal.Reset();
                    end;
                    rec.TestField("Location Code");
                    yitemJournal.Reset();
                    yitemJournal.setRange("Journal Template Name", 'ARTICLE');
                    yitemJournal.setRange("Journal Batch Name", 'TULIPE');
                    if yitemJournal.FindFirst() then
                        yitemJournal.DeleteAll();
                    if rec."Quantité" <> 0 then begin
                        itemJournal.Reset();
                        itemJournal.Init();
                        /*xitemJournal.Reset();
                        xitemJournal.SetRange("Journal Template Name", 'ARTICLE');
                        xitemJournal."Journal Batch Name" := 'DEFAUT';
                        if xitemJournal.FindLast() then
                            itemJournal.SetUpNewLine(xitemJournal);*/
                        itemJournal."Journal Template Name" := 'ARTICLE';
                        itemJournal."Journal Batch Name" := 'TULIPE';
                        itemJournal."Posting Date" := WorkDate();
                        itemJournal.Validate("Posting Date");

                        if Rec.Type = rec.Type::Negatif then begin
                            itemJournal."Entry Type" := itemJournal."Entry Type"::"Negative Adjmt.";
                            itemJournal.Quantity := rec."Quantité";
                            // itemJournal."Nombre de carton" := rec."Nombre Cartons";
                            // Message('a:%1', itemJournal."Nombre de carton");
                        end
                        else
                            if rec.Type = rec.Type::Positif then begin
                                itemJournal."Entry Type" := itemJournal."Entry Type"::"Positive Adjmt.";
                                itemJournal.Quantity := rec."Quantité";
                                // itemJournal."Nombre de carton" := rec."Nombre Cartons";
                                // Message('b:%1', itemJournal."Nombre de carton");
                            end
                            else
                                if rec.Type = rec.Type::Inventaire then begin
                                    if rec."Nombre Cartons" > 0 then begin
                                        if rec."curr Carton" < 0 then begin
                                            // silue samuel 07/03/2025 "pesée".Reset();
                                            // "pesée"."Document No." := rec."No." + 'inv';
                                            // "pesée"."Document Type" := "pesée"."Document Type"::Receipt;
                                            // "pesée".nombre := rec."curr Carton";
                                            // "pesée"."No." := rec."Item No.";
                                            // "pesée".Valid := true;
                                            // "pesée".verif := false;
                                            // "pesée"."Line No." := 10000;
                                            // "pesée".Num += 1;
                                            // "pesée".facture := true;
                                            // "pesée"."Location Code" := rec."Location Code";
                                            // "pesée".Insert();
                                            //fin silue samuel 07/03/2025---- Separator ----//

                                            // silue samuel 07/03/2025clear("ecritureCarton");
                                            // ecritureCarton."Posting date" := WorkDate();
                                            // "ecritureCarton"."Document No" := rec."No." + 'inv';
                                            // "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Positif";
                                            // "ecritureCarton"."Item No" := rec."Item No.";
                                            // "ecritureCarton"."Nombre de carton" := rec."curr Carton";
                                            // ecritureCarton.Poids := rec."curr Quantity";
                                            // ecritureCarton."Location Code" := rec."Location Code";
                                            //silue samuel 07/03/2025 "ecritureCarton".Insert(true);
                                        end else begin
                                            if rec."curr Carton" > 0 then begin
                                                // silue samuel 07/03/2025 "pesée".Reset();
                                                // "pesée"."Document No." := rec."No." + 'inv';
                                                // "pesée"."Document Type" := "pesée"."Document Type"::Order;
                                                // "pesée".nombre := rec."curr Carton";
                                                // "pesée"."No." := rec."Item No.";
                                                // "pesée".Valid := true;
                                                // "pesée".verif := false;
                                                // "pesée"."Line No." := 10000;
                                                // "pesée".Num += 1;
                                                // "pesée".facture := true;
                                                // "pesée"."Location Code" := rec."Location Code";
                                                // "pesée".Insert();
                                                //fin silue samuel 07/03/2025---- Separator ----//
                                                // clear("ecritureCarton");
                                                // ecritureCarton."Posting date" := WorkDate();
                                                // "ecritureCarton"."Document No" := rec."No." + 'inv';
                                                // "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Negatif";
                                                // "ecritureCarton"."Item No" := rec."Item No.";
                                                // "ecritureCarton"."Nombre de carton" := -rec."curr Carton";
                                                // ecritureCarton.Poids := -rec."curr Quantity";
                                                // ecritureCarton."Location Code" := rec."Location Code";
                                                //silue samuel 07/03/2025 "ecritureCarton".Insert(true);
                                            end;
                                        end;
                                        // silue samuel 07/03/2025 "pesée".Reset();
                                        // "pesée"."Document No." := rec."No." + 'inv';
                                        // "pesée"."Document Type" := "pesée"."Document Type"::Receipt;
                                        // "pesée".nombre := -rec."Nombre Cartons"/* - (rec."curr Carton")*/;
                                        // "pesée"."No." := rec."Item No.";
                                        // "pesée".Valid := true;
                                        // "pesée".verif := false;
                                        // "pesée"."Line No." := 20000;
                                        // "pesée".Num += 1;
                                        // "pesée".facture := true;
                                        // "pesée"."Location Code" := rec."Location Code";
                                        // fin silue samuel 07/03/2025"pesée".Insert();
                                        //---- Separator ----//
                                        // clear("ecritureCarton");
                                        // ecritureCarton."Posting date" := WorkDate();
                                        // "ecritureCarton"."Document No" := rec."No." + 'inv';
                                        // "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Positif";
                                        // "ecritureCarton"."Item No" := rec."Item No.";
                                        // "ecritureCarton"."Nombre de carton" := rec."Nombre Cartons";
                                        // ecritureCarton.Poids := rec."Quantité";
                                        // ecritureCarton."Location Code" := rec."Location Code";
                                        //silue samuel 07/03/2025 "ecritureCarton".Insert(true);

                                    end;
                                    if rec."Quantité" > 0 then begin
                                        if rec."curr Quantity" > rec."Quantité" then begin
                                            itemJournal."Entry Type" := itemJournal."Entry Type"::"Negative Adjmt.";
                                            itemJournal.Quantity := rec."curr Quantity" - rec."Quantité";
                                            // itemJournal."Nombre de carton" := 0;
                                        end else
                                            if rec."curr Quantity" < rec."Quantité" then begin
                                                itemJournal."Entry Type" := itemJournal."Entry Type"::"Positive Adjmt.";
                                                itemJournal.Quantity := rec."Quantité" - rec."curr Quantity";
                                                // itemJournal."Nombre de carton" := 0;
                                            end;
                                        ;
                                    end;
                                end;

                        itemJournal.Validate("Entry Type");
                        itemJournal."Line No." := 10000;
                        itemJournal.Validate("Line No.");
                        itemJournal."Document No." := rec."No.";
                        itemJournal.Validate("Document No.");
                        itemJournal."Item No." := rec."Item No.";
                        itemJournal.Validate("Item No.");
                        // silue samuel 07/03/2025 articl.Reset();
                        // articl.SetRange("No.", rec."Item No.");
                        // if articl.FindFirst() then begin
                        //     itemJournal."Gen. Prod. Posting Group" := articl."Gen. Prod. Posting Group";


                        end;
                        itemJournal.Validate("Gen. Prod. Posting Group");

                        itemJournal."Location Code" := rec."Location Code";
                        itemJournal.Validate(Quantity);
                        itemJournal.Insert();

                        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", itemJournal);
                        //<<Transfert de stock 29_08_24
                        // ItemLedger.SetRange("Document No.", itemJournal."Document No.");
                        // if ItemLedger.FindFirst() then begin

                            // repeat begin
                            // if ItemJournalLine."Nombre de cartonc" = 0 then begin
                            // if ItemLedger."Entry Type" = itemJournal."Entry Type"::"Positive Adjmt." then begin
                            //     ItemLedger."Lot Qty." := rec."Nombre Cartons";
                            //     // Message('Positif0:%1', rec."Nombre Cartons");
                            //     ItemLedger.Modify();
                            // end;
                            // if ItemLedger."Entry Type" = itemJournal."Entry Type"::"Negative Adjmt." then begin
                            //     ItemLedger."Lot Qty." := -REC."Nombre Cartons";
                            //     ItemLedger.Modify();
                            //     // Message('Negatif:%1', ItemLedger."Lot Qty.");
                            // end;
                            // end;

                            // end until ItemLedger.Next() = 0;

                        end;
                        //<<Transfert de stock 29_08_24
                        // rec."Posting Date" := WorkDate();
                        // rec.Posted := true;
                        // CurrPage.Editable := false;
                        // CurrPage.Close();
                    // end else begin
                        //Error('tst');

                        //ligneArticle.SetRange("Journal Batch Name", ItemJournalLine."Journal Batch Name");
                        //ligneArticle.SetRange("Journal Template Name", ItemJournalLine."Journal Template Name");
                        // silue samuel 07/03/2025 "pesée".Reset();
                        // fin silue samuel 07/03/2025 "pesée"."Document No." := rec."No.";
                        //---- Separator ----//
                        // clear("ecritureCarton");
                        // ecritureCarton."Posting date" := WorkDate();
                        //silue samuel 07/03/2025 "ecritureCarton"."Document No" := rec."No." + 'inv';


                        // if rec."Type" = rec."Type"::Positif then begin //Ajustement positif
                        //     //  silue samuel 07/03/2025 "pesée"."Document Type" := "pesée"."Document Type"::Receipt;
                        //     //fin silue samuel 07/03/2025 "pesée".nombre := -rec."Nombre Cartons";
                        //     //---- Separator ----//
                        //     // "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Positif";
                        //     // "ecritureCarton"."Nombre de carton" := rec."Nombre Cartons";
                        //     // silue samuel 07/03/2025ecritureCarton.Poids := rec."Quantité";
                        // end
                        // else
                        //     if rec."Type" = rec."Type"::Negatif then begin // Ajustement negatif
                        //         //  silue samuel 07/03/2025"pesée"."Document Type" := "pesée"."Document Type"::Order;
                        //         // "pesée".nombre := rec."Nombre cartons";
                        //         // fin silue samuel 07/03/2025 "pesée".facture := true;
                        //         // //---- Separator ----//
                        //         // "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Negatif";
                        //         // "ecritureCarton"."Nombre de carton" := -rec."Nombre Cartons";
                        //         // silue samuel 07/03/2025 ecritureCarton.Poids := -rec."Quantité";
                        //     end else
                        //         if rec.Type = rec.Type::Inventaire then begin
                        //             if rec."Nombre Cartons" > 0 then begin
                        //                 if rec."curr Carton" < 0 then begin
                        //                     // silue samuel 07/03/2025 "pesée2".Reset();
                        //                     // "pesée2"."Document No." := rec."No." + 'inv';
                        //                     // "pesée2"."Document Type" := "pesée"."Document Type"::Receipt;
                        //                     // "pesée2".nombre := rec."curr Carton";
                        //                     // "pesée2"."No." := rec."Item No.";
                        //                     // "pesée2".Valid := true;
                        //                     // "pesée2".verif := false;
                        //                     // "pesée2"."Line No." := 10000;
                        //                     // "pesée2".Num += 1;
                        //                     // "pesée2".facture := true;
                        //                     // "pesée2"."Location Code" := rec."Location Code";
                        //                     //fin silue samuel 07/03/2025  "pesée2".Insert();
                        //                     //---- Separator ----//

                        //                     // clear("ecritureCarton2");
                        //                     // "ecritureCarton2"."Posting date" := WorkDate();
                        //                     // "ecritureCarton2"."Document No" := rec."No." + 'inv';
                        //                     // "ecritureCarton2"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Positif";
                        //                     // "ecritureCarton2"."Item No" := rec."Item No.";
                        //                     // "ecritureCarton2"."Nombre de carton" := rec."curr Carton";
                        //                     // ecritureCarton2.Poids := rec."curr Quantity";
                        //                     // ecritureCarton2."Location Code" := rec."Location Code";
                        //                     // silue samuel 07/03/2025 "ecritureCarton2".Insert();
                        //                 end else begin
                        //                     if rec."curr Carton" > 0 then begin
                        //                         // silue samuel 07/03/2025 "pesée2".Reset();
                        //                         // "pesée2"."Document No." := rec."No." + 'inv';
                        //                         // "pesée2"."Document Type" := "pesée"."Document Type"::Order;
                        //                         // "pesée2".nombre := rec."curr Carton";
                        //                         // "pesée2"."No." := rec."Item No.";
                        //                         // "pesée2".Valid := true;
                        //                         // "pesée2".verif := false;
                        //                         // "pesée2"."Line No." := 10000;
                        //                         // "pesée2".Num += 1;
                        //                         // "pesée2".facture := true;
                        //                         // "pesée2"."Location Code" := rec."Location Code";
                        //                         // fin silue samuel 07/03/2025 "pesée2".Insert();
                        //                         //---- Separator ----//

                        //                         // clear("ecritureCarton2");
                        //                         // "ecritureCarton2"."Posting date" := WorkDate();
                        //                         // "ecritureCarton2"."Document No" := rec."No." + 'inv';
                        //                         // "ecritureCarton2"."Item No" := rec."Item No.";
                        //                         // "ecritureCarton2"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Negatif";
                        //                         // "ecritureCarton2"."Nombre de carton" := -rec."curr Carton";
                        //                         // ecritureCarton2.Poids := -rec."curr Quantity";
                        //                         // ecritureCarton2."Location Code" := rec."Location Code";
                        //                         //silue samuel 07/03/2025 "ecritureCarton2".Insert();
                        //                     end;
                        //                 end;
                        //                 // silue samuel 07/03/2025 "pesée"."Document Type" := "pesée"."Document Type"::Receipt;
                        //                 // fin silue samuel 07/03/2025 "pesée".nombre := -rec."Nombre Cartons"/* - (rec."curr Carton")*/;
                        //                 //--- Separator ---//
                        //                 // "ecritureCarton"."Document Type" := "ecritureCarton"."Document Type"::"Ajustement Positif";
                        //                 // "ecritureCarton"."Nombre de carton" := rec."Nombre Cartons";
                        //                 //silue samuel 07/03/2025 ecritureCarton.Poids := rec."Quantité";
                        //             end;
                        //         end;
                        // silue samuel 07/03/2025 "pesée"."No." := rec."Item No.";
                        // "pesée".Valid := true;
                        // "pesée".verif := false;
                        // "pesée"."Line No." := 10000;
                        // "pesée".Num += 1;
                        // "pesée".facture := true;
                        // "pesée"."Location Code" := rec."Location Code";
                        // fin silue samuel 07/03/2025 "pesée".Insert();
                        //---- Separator ----//
                        // ecritureCarton."Posting date" := WorkDate();
                        // "ecritureCarton"."Item No" := rec."Item No.";
                        // ecritureCarton."Location Code" := rec."Location Code";
                        //silue samuel 07/03/2025 "ecritureCarton".Insert(true);


                        // rec."Posting Date" := WorkDate();
                        // rec.Posted := true;
                        // CurrPage.Editable := false;
                        // Message('Ajustement validée');
                        // CurrPage.Close();
                    // end;
                // end;
            }
            action("Feuilles Article")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ItemLedger;
                // RunObject = Page 40;
                // RunPageMode = View;
                // Enabled = NOT rec.Posted;
            }
        }
    }

    var
        style: Option;


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        rec."Document Date" := WorkDate();
        // rec."Location Code" := 'SIEGE';
    end;

    trigger OnAftergetrecord()
    var
        myInt: Integer;
    begin
        if rec.Type = rec.Type::Negatif then begin

        end;

    end;

    trigger OnOpenPage()
    var
        //silue samuel 07/03/2025 item: record Item;
    begin
        // rec.Type := rec.Type::Inventaire;
        // item.SetRange("No.", rec."Item No.");
        // if item.FindFirst() then begin
        //     rec.Description := item.Description;
        //     rec."curr Carton" := item."Cartons Solde";
        //     item.CalcFields(Inventory);
        //     rec."curr Quantity" := item.Inventory;
        //     if rec.Posted then
        //         CurrPage.Editable := false;
        // end;
    end;
}